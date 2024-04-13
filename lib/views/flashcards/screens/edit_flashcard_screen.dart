import 'package:academic/theme.dart';
import 'package:academic/views/flashcards/components/convert_to_latex.dart';
import 'package:academic/views/flashcards/components/custom_snackbar.dart';
import 'package:academic/views/flashcards/components/latex_helper.dart';
import 'package:academic/views/flashcards/models/flashcard_model.dart';
import 'package:academic/views/flashcards/repositories/flashcard_repository.dart';
import 'package:academic/views/flashcards/screens/flashcard_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditFlashcardScreen extends StatefulWidget {
  final Flashcard flashcard;
  const EditFlashcardScreen({Key? key, required this.flashcard})
      : super(key: key);

  @override
  State<EditFlashcardScreen> createState() => _EditFlashcardScreenState();
}

enum FlashcardType { normal, complex }

class _EditFlashcardScreenState extends State<EditFlashcardScreen> {
  final _formKey = GlobalKey<FormState>();

  FlashcardType? type;
  bool showHelp = false;

  final FlashcardRepository flashcardRepository = FlashcardRepository();

  @override
  void initState() {
    super.initState();
    type = widget.flashcard.type == "normal"
        ? FlashcardType.normal
        : FlashcardType.complex;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController questionController =
        TextEditingController(text: widget.flashcard.question);
    final TextEditingController answerController =
        TextEditingController(text: widget.flashcard.answer);

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Flash Card", style: GoogleFonts.sora()),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => blueColor),
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
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => blueColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
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
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.orange.withOpacity(0.5),
                          ),
                          maxLines: 5,
                        ),
                        const SizedBox(height: 40),
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
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.orange.withOpacity(0.5),
                          ),
                          maxLines: 5,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        String question = questionController.text;
                        String answer = answerController.text;

                        if (_formKey.currentState!.validate()) {
                          String flashcardType =
                              type.toString().split('.').last;
                          String complex =
                              convertToLatex(answerController.text);

                          Flashcard editedFlashcard = Flashcard(
                            id: widget.flashcard.id,
                            chapter: widget.flashcard.chapter,
                            question: question,
                            type: flashcardType,
                            answer: answer,
                            complexAnswer: complex,
                          );

                          flashcardRepository.editFlashcard(
                              widget.flashcard, editedFlashcard);

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FlashcardScreen(
                                subjectId: widget.flashcard.id,
                                chapterName: widget.flashcard.chapter,
                              ),
                            ),
                            (route) => false,
                          );
                          showSuccessSnackBar(
                            context,
                            "Kartu Flash berhasil diedit!",
                          );
                        }
                      },
                      child: Text(
                        "Kirim",
                        style: GoogleFonts.sora(
                          color: whiteColor,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: blueColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 100),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (showHelp)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        "Memasukkan Persamaan & Rumus",
                        style: GoogleFonts.sora(
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
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
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
