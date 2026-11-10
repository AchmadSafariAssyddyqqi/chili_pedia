import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const _QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  int? _selectedAnswer;
  bool _answered = false;
  bool _isFinished = false;

  final List<_QuizQuestion> _questions = const [
    _QuizQuestion(
      question:
          'Terdapat bercak hitam melingkar konsentris pada buah cabai, lama-kelamaan mengeriput dan membusuk saat musim hujan. Serangan apakah ini?',
      options: [
        'Virus Gemini (Bule)',
        'Antraknosa (Patek / Busuk Buah)',
        'Lalat Buah',
        'Bercak Daun Cercospora',
      ],
      correctIndex: 1,
      explanation:
          'Antraknosa disebabkan oleh jamur Colletotrichum capsici yang berkembang sangat cepat dan ganas pada kondisi kelembapan tinggi di musim hujan.',
    ),
    _QuizQuestion(
      question:
          'Penyakit Virus Gemini (Bule / Kuning) pada tanaman cabai ditularkan oleh vektor serangga...',
      options: [
        'Kutu Kebul (Bemisia tabaci)',
        'Lalat Buah (Bactrocera sp.)',
        'Ulat Grayak',
        'Belalang Sembah',
      ],
      correctIndex: 0,
      explanation:
          'Kutu kebul merupakan vektor utama yang menghisap cairan tanaman terinfeksi lalu menyebarkan virus ke tanaman cabai sehat lainnya.',
    ),
    _QuizQuestion(
      question:
          'Buah cabai tampak mulus dari luar, namun saat dibelah terdapat belatung dan daging buah membusuk basah. Hama penyebabnya adalah...',
      options: [
        'Kutu Daun (Aphids)',
        'Thrips',
        'Lalat Buah (Bactrocera sp.)',
        'Tungau Merah',
      ],
      correctIndex: 2,
      explanation:
          'Lalat buah betina menyuntikkan telur ke dalam kulit cabai menggunakan ovipositor, yang kemudian menetas menjadi larva perusak daging buah.',
    ),
    _QuizQuestion(
      question:
          'Koloni serangga kecil di bawah permukaan daun cabai mengeluarkan cairan lengket yang memicu jamur jelaga. Serangga tersebut adalah...',
      options: [
        'Kutu Daun (Aphids)',
        'Kumbang Koksi',
        'Rayap Tanah',
        'Ulat Daun',
      ],
      correctIndex: 0,
      explanation:
          'Kutu daun menghasilkan embun madu manis yang menarik perhatian semut hitam dan menjadi media tumbuh jamur embun jelaga.',
    ),
    _QuizQuestion(
      question:
          'Untuk menangkap lalat buah jantan secara ramah lingkungan, petani dapat memasang perangkap atraktan beraroma...',
      options: [
        'Mankozeb',
        'Petrogenol / Metil Eugenol',
        'Abamektin',
        'Tiametoksam',
      ],
      correctIndex: 1,
      explanation:
          'Petrogenol (senyawa pemikat berbasis metil eugenol) efektif memikat lalat buah jantan ke dalam botol perangkap bekas air mineral.',
    ),
  ];

  void _submitAnswer(int index) {
    if (_answered) return;

    setState(() {
      _selectedAnswer = index;
      _answered = true;
      if (index == _questions[_currentIndex].correctIndex) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
        _selectedAnswer = null;
        _answered = false;
      } else {
        _isFinished = true;
      }
    });
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _selectedAnswer = null;
      _answered = false;
      _isFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        title: const Text(
          'Uji Pemahaman Hama & Penyakit',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        backgroundColor: const Color(0xFF1B5E20),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isFinished ? _buildResultScreen() : _buildQuizBody(),
    );
  }

  Widget _buildQuizBody() {
    final currentQ = _questions[_currentIndex];
    final progress = (_currentIndex + 1) / _questions.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pertanyaan ${_currentIndex + 1} dari ${_questions.length}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
              Text(
                'Skor: $_score',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF15803D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2E7D32)),
            ),
          ),
          const SizedBox(height: 20),

          // Question Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              currentQ.question,
              style: const TextStyle(
                fontSize: 16.5,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
                height: 1.45,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Options List
          ...List.generate(currentQ.options.length, (index) {
            final option = currentQ.options[index];
            final bool isSelected = _selectedAnswer == index;
            final bool isCorrect = index == currentQ.correctIndex;

            Color borderColor = const Color(0xFFE5E7EB);
            Color bgColor = Colors.white;
            Color textColor = const Color(0xFF374151);
            IconData? icon;

            if (_answered) {
              if (isCorrect) {
                borderColor = const Color(0xFF059669);
                bgColor = const Color(0xFFECFDF5);
                textColor = const Color(0xFF065F46);
                icon = Icons.check_circle_rounded;
              } else if (isSelected) {
                borderColor = const Color(0xFFDC2626);
                bgColor = const Color(0xFFFEF2F2);
                textColor = const Color(0xFF991B1B);
                icon = Icons.cancel_rounded;
              }
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: _answered ? null : () => _submitAnswer(index),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: borderColor, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _answered && isCorrect
                                ? const Color(0xFF059669)
                                : (_answered && isSelected
                                    ? const Color(0xFFDC2626)
                                    : const Color(0xFFF3F4F6)),
                          ),
                          child: Center(
                            child: icon != null
                                ? Icon(icon, size: 18, color: Colors.white)
                                : Text(
                                    String.fromCharCode(65 + index), // A, B, C, D
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Color(0xFF4B5563),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 14.5,
                              fontWeight: isSelected || (_answered && isCorrect)
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),

          // Explanation Banner after answer
          if (_answered) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _selectedAnswer == currentQ.correctIndex
                            ? Icons.check_circle_outline
                            : Icons.info_outline,
                        color: const Color(0xFF166534),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _selectedAnswer == currentQ.correctIndex
                            ? 'Jawaban Anda Benar!'
                            : 'Penjelasan Jawaban Tepat:',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF166534),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    currentQ.explanation,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.45,
                      color: Color(0xFF14532D),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _nextQuestion,
                icon: const Icon(Icons.arrow_forward, color: Colors.white),
                label: Text(
                  _currentIndex == _questions.length - 1
                      ? 'Lihat Hasil Akhir'
                      : 'Pertanyaan Selanjutnya',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultScreen() {
    final int total = _questions.length;
    final double percentage = (_score / total) * 100;

    String title;
    String subtitle;
    Color badgeColor;
    IconData badgeIcon;

    if (_score == total) {
      title = 'Luar Biasa! Pakar Cabai';
      subtitle = 'Pemahaman Anda mengenai hama & penyakit cabai sangat sempurna!';
      badgeColor = const Color(0xFF15803D);
      badgeIcon = Icons.military_tech_rounded;
    } else if (_score >= 3) {
      title = 'Hebat! Penyuluh Terampil';
      subtitle = 'Anda sudah menguasai sebagian besar teknik identifikasi dan pengendalian.';
      badgeColor = const Color(0xFFD97706);
      badgeIcon = Icons.thumb_up_alt_rounded;
    } else {
      title = 'Terus Belajar, Calon Petani Hebat';
      subtitle = 'Baca kembali ringkasan pengendalian di menu daftar penyakit dan hama.';
      badgeColor = const Color(0xFFDC2626);
      badgeIcon = Icons.menu_book_rounded;
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: badgeColor.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(color: badgeColor.withOpacity(0.3), width: 3),
              ),
              child: Icon(badgeIcon, size: 70, color: badgeColor),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: badgeColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4B5563),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            // Score Board
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Skor Akhir Anda',
                    style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$_score / $total',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: badgeColor,
                    ),
                  ),
                  Text(
                    '${percentage.toInt()}% Ketepatan Jawaban',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _restartQuiz,
                    icon: const Icon(Icons.refresh, color: Color(0xFF1B5E20)),
                    label: const Text(
                      'Ulangi Kuis',
                      style: TextStyle(
                        color: Color(0xFF1B5E20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFF1B5E20)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.home, color: Colors.white),
                    label: const Text(
                      'Ke Beranda',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1B5E20),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

