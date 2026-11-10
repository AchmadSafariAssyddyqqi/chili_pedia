import 'package:flutter/material.dart';
import '../models/pest_disease_model.dart';

class ChiliData {
  static const String kebunBannerAsset = 'assets/images/kebun_cabai.png';

  static const List<PestDiseaseModel> items = [
    // ==========================================
    // KATEGORI A: PENYAKIT (Jamur & Virus)
    // ==========================================
    PestDiseaseModel(
      id: 'penyakit_1',
      name: 'Virus Gemini (Bule / Kuning)',
      alias: 'Pepper Yellow Leaf Curl Virus (PepYLCV)',
      category: CategoryType.penyakit,
      attackedPart: 'Daun',
      symptoms:
          'Daun cabai berubah warna menjadi kuning terang (bule), melengkung ke atas, keriting, dan ukuran daun mengecil secara drastis. Pertumbuhan pohon menjadi kerdil dan tanaman tidak mampu berbuah secara lebat.',
      cause:
          'Infeksi virus dari kelompok Geminiviridae yang ditularkan melalui vektor serangga Kutu Kebul (Bemisia tabaci).',
      controlMethod:
          '1. Cabut dan bakar atau kubur tanaman yang sudah terinfeksi parah agar tidak menular ke tanaman sehat lainnya.\n'
          '2. Kendalikan populasi vektor dengan menyemprotkan insektisida berbahan aktif Abamektin atau Imidakloprid.\n'
          '3. Gunakan mulsa plastik perak untuk memantulkan sinar matahari dan menghalau kutu kebul.',
      icon: Icons.coronavirus_outlined,
      primaryColor: Color(0xFFD97706), // Amber-orange
      accentColor: Color(0xFFFEF3C7),
      tag: 'Virus Mematikan',
      imageAsset: 'assets/images/gemini_virus.png',
    ),
    PestDiseaseModel(
      id: 'penyakit_2',
      name: 'Antraknosa (Patek / Busuk Buah)',
      alias: 'Colletotrichum capsici / Patek Buah',
      category: CategoryType.penyakit,
      attackedPart: 'Buah Cabai',
      symptoms:
          'Muncul bercak hitam melingkar konsentris pada kulit buah cabai. Seiring waktu, bercak semakin melebar, buah mengeriput, kering, membusuk berair, dan akhirnya gugur sebelum matang.',
      cause:
          'Cendawan/jamur Colletotrichum capsici. Perkembangan jamur ini sangat cepat dan ganas terutama pada kondisi kelembapan tinggi dan musim hujan.',
      controlMethod:
          '1. Hindari penggunaan benih dari buah cabai yang pernah terserang penyakit.\n'
          '2. Semprotkan fungisida protektif/kuratif berbahan aktif Mankozeb atau Propineb secara teratur sesuai dosis.\n'
          '3. Atur jarak tanam ideal (minimal 50-60 cm) agar sirkulasi udara lancar dan kebun tidak terlalu lembap.',
      icon: Icons.grain_outlined,
      primaryColor: Color(0xFFDC2626), // Red
      accentColor: Color(0xFFFEE2E2),
      tag: 'Jamur Buah',
      imageAsset: 'assets/images/antraknosa.png',
    ),
    PestDiseaseModel(
      id: 'penyakit_3',
      name: 'Bercak Daun (Cercospora)',
      alias: 'Cercospora capsici / Frog-Eye Spot',
      category: CategoryType.penyakit,
      attackedPart: 'Daun',
      symptoms:
          'Muncul bercak-bercak bulat kecil berwarna cokelat tua dengan bagian tengah (pusat) berwarna putih pucat abu-abu (menyerupai mata katak). Pada serangan parah, bercak berlubang, daun menguning, lalu gugur massal (defoliasi).',
      cause:
          'Infeksi jamur Cercospora capsici yang spora-nya mudah menyebar melalui percikan air hujan dan hembusan angin kencang.',
      controlMethod:
          '1. Petik dan buang daun-daun yang terinfeksi pada awal gejala, jangan biarkan menumpuk di tanah.\n'
          '2. Semprotkan fungisida berbahan aktif Difenokonazol atau Klorotalonil secara berkala sesuai dosis anjuran.\n'
          '3. Bersihkan gulma di sekitar bedengan untuk mengurangi kelembapan mikro di sekitar tanaman.',
      icon: Icons.eco_outlined,
      primaryColor: Color(0xFF059669), // Emerald Green
      accentColor: Color(0xFFD1FAE5),
      tag: 'Jamur Daun',
      imageAsset: 'assets/images/bercak_daun.png',
    ),

    // ==========================================
    // KATEGORI B: HAMA (Serangga Perusak)
    // ==========================================
    PestDiseaseModel(
      id: 'hama_1',
      name: 'Kutu Daun (Aphids)',
      alias: 'Aphis gossypii / Kutu Daun Hijau-Hitam',
      category: CategoryType.hama,
      attackedPart: 'Daun muda dan Pucuk tanaman',
      symptoms:
          'Terlihat koloni serangga kecil bertubuh lunak berwarna hijau muda atau kehitaman bergerombol di bagian bawah permukaan daun dan tunas muda. Daun mengalami keriting, menggulung, pertumbuhan pucuk terhambat, dan terdapat embun madu lengket yang memicu jamur jelaga hitam.',
      cause:
          'Serangga hama penusuk dan pengisap cairan sel tanaman cabai yang berkembang biak dengan sangat cepat.',
      controlMethod:
          '1. Pasang perangkap lekat kuning (Yellow Sticky Trap) setinggi tajuk tanaman untuk memantau dan menangkap kutu dewasa.\n'
          '2. Lakukan penyemprotan insektisida nabati seperti ekstrak daun nimba, tembakau, atau larutan bawang putih.\n'
          '3. Bila populasi melebihi ambang batas ekonomi, semprotkan insektisida sistemik berbahan aktif Tiametoksam atau Imidakloprid.',
      icon: Icons.pest_control_outlined,
      primaryColor: Color(0xFF7C3AED), // Violet
      accentColor: Color(0xFFEDE9FE),
      tag: 'Pengisap Sel Daun',
      imageAsset: 'assets/images/kutu_daun.png',
    ),
    PestDiseaseModel(
      id: 'hama_2',
      name: 'Lalat Buah',
      alias: 'Bactrocera sp. / Fruit Fly',
      category: CategoryType.hama,
      attackedPart: 'Buah Cabai',
      symptoms:
          'Tampak luar buah cabai sering terlihat mulus atau hanya terdapat titik bekas tusukan jarum ovipositor. Namun saat buah dibelah, bagian dalamnya berulat (larva belatung), daging buah busuk basah, dan buah rontok sebelum waktunya matang sempurna.',
      cause:
          'Lalat buah betina (Bactrocera sp.) menusuk kulit cabai menggunakan ovipositor untuk meletakkan butiran telur di dalam daging buah yang kemudian menetas menjadi larva perusak.',
      controlMethod:
          '1. Pasang perangkap atraktan beraroma pemikat (seperti Petrogenol / Metil Eugenol) di dalam botol plastik bekas air mineral untuk menangkap lalat jantan.\n'
          '2. Kumpulkan seluruh buah cabai yang busuk dan rontok ke dalam kantong tertutup atau kubur ke dalam tanah sedalam minimal 50 cm agar larva mati.\n'
          '3. Bungkus atau lakukan rotasi lahan penanaman untuk memutus siklus hidup hama.',
      icon: Icons.bug_report_outlined,
      primaryColor: Color(0xFFEA580C), // Deep Orange
      accentColor: Color(0xFFFFEDD5),
      tag: 'Perusak Buah',
      imageAsset: 'assets/images/lalat_buah.png',
    ),
  ];

  static List<PestDiseaseModel> getBycategory(CategoryType category) {
    return items.where((item) => item.category == category).toList();
  }

  static int getCount(CategoryType category) {
    return items.where((item) => item.category == category).length;
  }
}
