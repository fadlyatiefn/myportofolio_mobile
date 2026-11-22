## Biodata
Nama : Fadly Atief

NPM : 2506624940

Kelas : PBP A

## Tugas 1 - 6
Untuk melihat histori dari Tugas 1 - Tugas 6, bisa dilihat pada link berikut:

https://github.com/fadlyatiefn/myportofolio

## Tugas 7

### ❓ Pertanyaan

## 1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!

Di Flutter semuanya adalah widget. Widget tree adalah susunan widget bertingkat yang dipakai Flutter untuk bikin tampilan, dibaca dari widget terluar (root) ke yang terdalam.

Hubungan induk-anak:
- Widget induk yang ngatur gimana layout anaknya, dan bisa di-style.
- Anak nerima every constraint dari induknya, lalu anak yang nentuin ukurannya sendiri dalam batasan itu.
- Satu widget bisa punya satu anak atau banyak anak.
- Kalau induk di-rebuild, anak-anaknya ikut dibangun ulang.

Contoh di proyek ini: `Scaffold` jadi induk `AppBar` dan `body`. Di dalam `body`, `Padding` bungkus `Column`, dan `Column` isinya `Row` (3 `InfoCard`) sama `GridView.count` (item menu).

## 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!

Dari `lib/main.dart` dan `lib/menu.dart`:

| Widget | Fungsi di proyek |
|---|---|
| `MaterialApp` | Root app dengan style MaterialApp. ngatur judul, tema, dan halaman awal (`MyHomePage`). |
| `Scaffold` | Kerangka halaman, nyediain `appBar` dan `body`, juga konteks buat nampilin `SnackBar`. |
| `PreferredSize` | Nentuin ukuran yang diinginin buat area app bar. |
| `SafeArea` | Jaga isi app bar biar nggak ketutup notch/area sistem. |
| `Padding` | Ngasih jarak di sekitar widget anak. |
| `FractionallySizedBox` | Ngatur lebar app bar berdasarkan fraksi dari lebar yang tersedia. |
| `AppBar` | Bilah atas yang nampilin judul aplikasi. |
| `RoundedRectangleBorder` | Bikin bentuk app bar dengan sudut membulat. |
| `Text` | Nampilin judul, biodata, pesan sambutan, dan isi `SnackBar`. |
| `Column` | Nyusun konten secara vertikal. |
| `Row` | Nyusun tiga kartu info secara horizontal. |
| `InfoCard` (custom) | Nampilin label + isi biodata dalam satu kartu. |
| `Card` | Ngasih tampilan kartu buat info biodata. |
| `Container` | Ngatur ukuran dan padding isi kartu. |
| `SizedBox` | Jarak tetap antar widget, misal antar teks. |
| `Center` | Nempatin konten di tengah area yang tersedia. |
| `GridView.count` | Nampilin item menu dalam grid tiga kolom. |
| `ItemCard` (custom) | Satu tombol menu di grid. |
| `Material` | Ngasih warna dan bentuk material ke kartu menu. |
| `InkWell` | Nangkep tap di kartu menu + efek ripple. |
| `Icon` | Nampilin ikon di kartu menu. |
| `SnackBar` | Pesan singkat yang muncul pas kartu menu ditekan. |

Notes: `StatelessWidget`, `BuildContext`, `ThemeData`, `ColorScheme`, `TextStyle`, `EdgeInsets`, `Color` kelihatan di kode tapi bukan widget yang dipasang di tree. Mereka kelas dasar, parameter, atau objek pendukung.

## 3. Apa fungsi dari widget `MaterialApp`? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!

`MaterialApp` itu widget tingkat atas yang nyediain fasilitas umum buat app bergaya Material:
- **Tema** (`ThemeData`, `ColorScheme`) yang dipakai semua widget di bawahnya.
- **Navigasi/routing** (`home`, `routes`, `Navigator`).
- **Judul app**, plus dukungan lokalisasi.

Di proyek ini, dia ngatur judul dan tema, terus milih `MyHomePage` sebagai halaman awal.

Kenapa jadi root: widget Material kayak `Scaffold`, `AppBar`, `Card`, `InkWell`, dan `SnackBar` butuh konfigurasi itu dari ancestor-nya. Karena `MaterialApp` ada di paling atas, semua widget di bawahnya bisa akses lewat context, contohnya `Theme.of(context)` di proyek ini. Jadi tema dan navigasi cukup diatur sekali di satu tempat.

## 4. Jelaskan perbedaan antara `StatelessWidget` dan `StatefulWidget`! Kapan kita sebaiknya memilih `StatelessWidget` dan kapan harus menggunakan `StatefulWidget`?

**Perbedaan:**
- `StatelessWidget`: nggak nyimpen state yang berubah selama widget hidup. Tampilannya cuma ditentuin data/parameter yang diterima. Di proyek ini: `MyApp`, `MyHomePage`, `InfoCard`, `ItemCard`.
- `StatefulWidget`: punya objek `State` terpisah yang nyimpen data yang bisa berubah. Kalau state berubah lewat `setState()`, Flutter manggil `build` ulang buat bagian itu.

**Kapan pakai yang mana:**
- Pilih `StatelessWidget` kalau tampilan nggak berubah sendiri atau cukup ditentuin data dari luar (label, ikon, kartu statis).
- Pilih `StatefulWidget` kalau UI harus update karena sesuatu berubah di dalam widget, misal counter, checkbox/pilihan aktif, input form, atau data hasil fetch.

Default-nya mulai dari stateless, naik ke stateful kalau emang butuh state lokal.

## 5. Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode `build`?

`BuildContext` itu referensi ke posisi sebuah widget di dalam widget tree. Flutter ngasih dia sebagai parameter ke `build(BuildContext context)`.

**Kenapa penting:** dari context, widget bisa "nanjak" ke ancestor-nya buat ngambil info atau layanan yang tersedia di atasnya, tanpa harus dioper manual lewat parameter.

**Pemakaian di `build` (proyek ini):**
- `Theme.of(context)`: ngambil tema dari `MaterialApp`.
- `MediaQuery.of(context)`: ngambil ukuran layar.
- `ScaffoldMessenger.of(context).showSnackBar(...)`: nampilin `SnackBar` lewat `ScaffoldMessenger` terdekat.

Posisi context ngaruh: context harus ada di bawah widget yang nyediain hal yang mau diakses. Kalau nggak, lookup-nya gagal.

## 6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?

**Hot reload:** nyuntik kode yang berubah ke app yang lagi jalan, terus rebuild widget tree, dan state tetap kejaga. Cocok buat ubah UI atau logika di `build`.

**Hot restart:** app dijalanin ulang dari awal, jadi semua state di memori ilang dan `main()` jalan lagi. Tapi proses build dan koneksi ke device tetap, jadi lebih cepat dari full restart.

**Full restart:** app dihentiin total lalu di-build dan dijalanin ulang.

**Kapan hot reload nggak cukup:**
- Hot restart: ubah inisialisasi state (nilai awal variabel/state global, `initState`, `main()`), atau perubahan yang cuma kebaca pas app mulai.
- Full restart: ubah konfigurasi native Android/iOS, tambah/ubah plugin native atau dependency di `pubspec.yaml`, atau ubah kode platform.

Kalau hot reload nggak nunjukin perubahan, naik ke hot restart, kalau masih nggak, full restart.

### 📶 Progress Mingguan
**Untuk Full *Commit History*, bisa lihat di branch tugas-3**
- 9 November 2026:
    1. Menyelesaikan Tutorial 8
    2. Mengganti warna action button
    3. Menambah action button
- 16 November 2026:
    1. Mengupdate isi README.md

### 🤖 AI Disclosure

#### AI Tools yang Digunakan

- **Claude** : Untuk membantu dalam oengisian README.md
    
#### Keterbatasan AI

AI hanya bisa berjalan dengan baik dan sesuai kemauan saya ketika saya memberikan referensi yang banyak. Yang mana dalam mencari referensi, tentunya kita harus memahami apa yg dimau kita secara detail, Oleh karena itu, saya juga perlu memahami secara mendalam mengenai tugas ini


#### Perbaikan Manual
Melakukan pengecekan pada hasil output AI dan juga memperbaiki bagian - bagian yang tidak kompatibel / tidak sesuai sehingga web aku dapat berjalan sesuai dengan ketentuan.

## Tugas 8

### ❓ Pertanyaan

## 1. Jelaskan perbedaan antara `Navigator.push()`, `Navigator.pushReplacement()`, dan `Navigator.pop()`! Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi **Home** di drawer membawa pengguna kembali ke halaman utama.

**Perbedaannya:**
- `Navigator.push()` menambahkan halaman baru di atas halaman saat ini. Pengguna bisa kembali ke halaman sebelumnya dengan tombol Back atau `Navigator.pop()`.
- `Navigator.pushReplacement()` mengganti halaman saat ini dengan halaman baru. Halaman yang diganti tidak lagi berada di tumpukan navigasi.
- `Navigator.pop()` menutup halaman yang sedang terbuka dan kembali ke halaman sebelumnya di tumpukan navigasi.

Di `ItemCard`, kartu **Tambah Proyek** dan **Tambah Experience** menggunakan `Navigator.push()` untuk membuka formulir masing-masing. Halaman utama tetap berada di bawah formulir, sehingga pengguna bisa kembali ke sana.

Opsi **Home** di `LeftDrawer` menggunakan `Navigator.pushReplacement()` untuk membuka `MyHomePage` dan mengganti halaman saat ini. Dengan begitu, pengguna kembali ke halaman utama tanpa menyimpan halaman sebelumnya sebagai halaman aktif di tumpukan navigasi.

## 2. Bagaimana susunan `Scaffold`, `AppBar`, dan `Drawer` membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.

`Scaffold` menyediakan kerangka dasar halaman, seperti area `appBar`, `body`, dan `drawer`. `AppBar` menampilkan judul serta menyediakan area navigasi di bagian atas, sedangkan `Drawer` menyediakan menu untuk berpindah halaman. Susunan ini membuat fungsi dan struktur halaman lebih mudah dikenali pengguna.

Contoh warna yang digunakan berulang adalah indigo. Halaman utama mengambil warna utama dari `Theme.of(context).colorScheme.primary` untuk `AppBar`, yang berasal dari tema aplikasi dengan `seedColor: Colors.indigo`. Pada formulir proyek dan pengalaman, `AppBar` serta tombol **Save** juga menggunakan `Colors.indigo`.

## 3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.

Formulir disusun dengan `Column` karena kolom input dan tombol disajikan secara berurutan dari atas ke bawah. Setiap kolom input dibungkus `Padding` agar memiliki jarak dari elemen lain dan tidak terlihat terlalu rapat.

`SingleChildScrollView` membungkus isi formulir supaya pengguna dapat menggulir ke bagian bawah ketika seluruh kolom dan tombol tidak muat di layar. Ini berguna pada layar yang pendek atau saat papan ketik sedang terbuka.

## 4. Apa peran `GlobalKey<FormState>`, `validator`, dan `validate()` saat tombol **Simpan** ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.

`GlobalKey<FormState>` menghubungkan `Form` dengan kode yang perlu memeriksa atau mengatur statusnya. Pada tombol **Save**, `_formKey.currentState!.validate()` menjalankan `validator` pada field yang memiliki validasi.

`validator` memeriksa nilai sebuah field dan mengembalikan pesan jika nilainya tidak memenuhi aturan. Contohnya, nama proyek yang hanya berisi spasi ditolak karena validator memeriksa apakah `value.trim().isEmpty`. Jika semua field yang divalidasi lolos, `validate()` menghasilkan `true` dan dialog keberhasilan ditampilkan.

Memilih jenis input atau papan ketik hanya membantu pengguna memasukkan nilai dalam format tertentu. Itu tidak menjamin nilainya valid, karena pengguna masih bisa menempelkan teks atau mengosongkan field. Karena itu, pemeriksaan tetap perlu dilakukan dengan `validator` saat formulir dikirim.

### 📶 Progress Mingguan
**Untuk Full *Commit History*, bisa lihat di branch tugas-3**
- 22 November 2026:
    1. Membuat halaman form experience
    2. Menambah routing di menu untuk ke halaman form experience
    3. Menambah isi README.md

### 🤖 AI Disclosure

#### AI Tools yang Digunakan

- **Claude** : Untuk membantu dalam pengisian README.md dan fix error saat menambahkan DateTimeField
    
#### Keterbatasan AI

AI hanya bisa berjalan dengan baik dan sesuai kemauan saya ketika saya memberikan referensi yang banyak. Yang mana dalam mencari referensi, tentunya kita harus memahami apa yg dimau kita secara detail, Oleh karena itu, saya juga perlu memahami secara mendalam mengenai tugas ini


#### Perbaikan Manual
Melakukan pengecekan pada hasil output AI dan juga memperbaiki bagian - bagian yang tidak kompatibel / tidak sesuai sehingga app aku dapat berjalan sesuai dengan ketentuan.