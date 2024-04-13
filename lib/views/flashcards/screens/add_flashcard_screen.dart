import 'package:academic/theme.dart';
import 'package:academic/views/flashcards/components/convert_to_latex.dart';
import 'package:academic/views/flashcards/components/custom_snackbar.dart';
import 'package:academic/views/flashcards/components/latex_helper.dart';
import 'package:academic/views/flashcards/models/flashcard_model.dart';
import 'package:academic/views/flashcards/repositories/flashcard_repository.dart';
import 'package:academic/views/flashcards/screens/flashcard_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddFlashCardScreen extends StatefulWidget {
  final String subjectId;
  final String chapterName;
  const AddFlashCardScreen(
      {Key? key, required this.subjectId, required this.chapterName})
      : super(key: key);

  @override
  State<AddFlashCardScreen> createState() => _AddFlashCardScreenState();
}

enum FlashcardType { normal, complex }

class _AddFlashCardScreenState extends State<AddFlashCardScreen> {
  final _formKey = GlobalKey<FormState>();

  FlashcardType? type = FlashcardType.normal;
  final TextEditingController questionController = TextEditingController();
  final TextEditingController answerController = TextEditingController();
  bool showHelp = false;
  final FlashcardRepository flashcardRepository = FlashcardRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambahkan Flashcard Baru", style: GoogleFonts.sora()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close)),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/background.gif'), // Ganti dengan path gambar GIF Anda
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(
                          0.8), // Ubah opasitas sesuai keinginan Anda
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.orange,
                          width: 2), // Tambahkan border dengan warna orange
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Normal',
                              style: GoogleFonts.sora(
                                color: blueColor,
                                fontSize: 18,
                              ),
                            ),
                            Radio<FlashcardType>(
                              value: FlashcardType.normal,
                              groupValue: type,
                              onChanged: (FlashcardType? value) {
                                setState(() {
                                  type = value;
                                });
                              },
                            ),
                            Text(
                              'Kompleks',
                              style: GoogleFonts.sora(
                                color: blueColor,
                                fontSize: 18,
                              ),
                            ),
                            Radio<FlashcardType>(
                              value: FlashcardType.complex,
                              groupValue: type,
                              onChanged: (FlashcardType? value) {
                                setState(() {
                                  type = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Silakan masukkan pertanyaan";
                                  }
                                  return null;
                                },
                                style: GoogleFonts.sora(color: Colors.black),
                                controller: questionController,
                                decoration: InputDecoration(
                                  labelText: "Pertanyaan",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        15), // Tambahkan border radius
                                  ),
                                  filled: true,
                                  fillColor: Colors.orange.withOpacity(
                                      0.5), // Ubah warna dan opasitas sesuai keinginan Anda
                                ),
                                maxLines: 5,
                              ),
                              const SizedBox(height: 20),
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Silakan masukkan jawaban";
                                  }
                                  return null;
                                },
                                style: GoogleFonts.sora(color: Colors.black),
                                controller: answerController,
                                decoration: InputDecoration(
                                  labelText: "Jawaban",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        15), // Tambahkan border radius
                                  ),
                                  filled: true,
                                  fillColor: Colors.orange.withOpacity(
                                      0.5), // Ubah warna dan opasitas sesuai keinginan Anda
                                ),
                                maxLines: 5,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            String question = questionController.text;
                            String answer = answerController.text;

                            if (_formKey.currentState!.validate()) {
                              String flashcardType =
                                  type.toString().split('.').last;
                              String complex =
                                  convertToLatex(answerController.text);

                              Flashcard flashcard = Flashcard(
                                id: widget.subjectId,
                                chapter: widget.chapterName,
                                question: question,
                                type: flashcardType,
                                answer: answer,
                                complexAnswer: complex,
                              );

                              await flashcardRepository.addFlashcard(flashcard);

                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FlashcardScreen(
                                    subjectId: widget.subjectId,
                                    chapterName: widget.chapterName,
                                  ),
                                ),
                              );
                              showSuccessSnackBar(
                                context,
                                "Flashcard berhasil ditambahkan!",
                              );
                            }
                          },
                          child: Text(
                            "Kirim",
                            style: GoogleFonts.sora(
                                color: whiteColor, fontSize: 16),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary:
                                blueColor, // Ubah warna sesuai keinginan Anda
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Tambahkan border radius
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showHelp)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black
                      .withOpacity(0.7), // Ubah opasitas sesuai keinginan Anda
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      "Memasukkan Persamaan & Rumus",
                      style: GoogleFonts.sora(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 8),
                    table,
                    IconButton(
                      onPressed: () {
                        setState(() {
                          showHelp = !showHelp;
                        });
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
