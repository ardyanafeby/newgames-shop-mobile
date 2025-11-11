# Newgames shop

<details>
<summary> Tugas 7</summary> 

### 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.


Widget tree adalah struktur hirarki berbentuk pohon yang menggambarkan hubungan dan susunan antar widget pada Flutter. Widget tree dapat terdiri atas root widget, parent widget, dan child widget. Dalam flutter hubungan antara parent dan child sangat berpengaruh. Parent bertanggung jawab untuk membuat dan mengonfigurasikan child widgetnya. Tugas dari parent widget terdiri dari: menentukan posisi child, memberikan batas ukuran, dan mengirimkan data ke child melalui constructor. Karena hal ini, jika parent di-rebuild, maka akan berpengaruh terhadap child (child akan ikut berubah).

### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

<li> Material App </li>
Material App di sini berfungsi sebagai widget utama (root) yang menjadi pondasi. Utamanya, material app ini berfungsi untuk mengatur tema, title, dan navigasi pada halaman.

<li> Scalffold</li>
Scalffold berfungsi sebagai struktur/kerangka dasar pada halaman yang menyediakan kerangka UI seperti AppBar, Body, dan SnackBar.

<li> AppBar </li>
Menampilkan header aplikasi yang memuat judul halaman dan <i>action icon</i> 

<li> Icon </li>
Menampilkan ikon-ikon grafis seperti tombol panah, logout, newspaper, dll.

<li> Column </li>
Menyusun widget secara vertikal dari atas ke bawah

<li> Center </li>
Menempatkan child widget tepat di tengah layar

<li> Container </li>
Mengatur ukuran, padding, margin, warna, dan dekorasi pada elemen.

<li> Padding </li> Memberikan inner spacing antara parent dan child.

<li> Inkwell </li>
Memberikan </i>ripple effect</i> pada saat widget ditekan.

<li> Material </li>
Memberikan efek seeprti bayangan, warna dasar, dan efek klik pada widget di dalamnya.

<li> SnackBar </li>
Menampilkan pesan notifikasi singkat di bagian bawa layar.

<li> ItemCard (Custom)</li> 
Menampilkan card berisi ikon dan teks di halaman utama (tombol menu).

<li> 
ItemHomePage (Custom)</li>
Kelas model yang menyimpan data untuk setiap kartu (item) seperti nama dan ikon yang akan ditampilkan di ItemCard.


### 3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

Seperti yang sebelumnya sudah disebutkan di atas, MaterialApp merupakan pondasi dan tugas utamanya adalah mengatur konfigurasi global pada mobile app seperti mengatur tema dan warna, menyediakan navigarasi dan routing, mengatur properti global, dan lainnya. MaterialApp sering dijadikan sebagai widget root karena di MaterialApp sudah disediakan sekuruh struktur aplikasi bawaan yag berbasis dengan pedoman desain Google, sehingga desain dan material yang digunakan akan konsisten. Selain itu, memudahkan developer untuk mengatur tampilan dan interaksi seluruh halaman di satu tempat.

### 4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya? ###
StatelessWidget tidak memiliki state yang bisa berubah setelah dibuat, sehingga hanya dibangun sekali saja pada  saat ditampikan. Contohnya seperti text dan icon yang tidak akan berubah. Sedangkan StatefulWidget memiliki state yang bisa berubah-ubah selama aplikasi dijalankan, StatefulWidget di-rebuid setiap kali statenya berubah, sehingga tampilannya dinamis.

### 5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?

BuildContext adalah objek yang merepresentasikan lokasi (posisi) sebuah widget di dalam widget tree aplikasi Flutter.
Setiap widget yang ditampilkan di layar memiliki context-nya sendiri, yang memberi tahu di mana widget tersebut berada dan apa saja widget induk (parent) yang membungkusnya. BuildContext penting karena mengakses widget lain di atasnya, menentukan tampilan (theme, text, text style, warna) berdasarkan hierarki UI, mengelola navigasi antar halaman, dan menampilkan komponen sementara seperti SnackBar di Scaffold yang sesuai. Dalam metode build, widgetnya di override dan parameter contextnya digunakan untuk membangun tampilan dan mengakses elemen-elemen aplikasi yang terkait dengan posisi widget tersebut.

### 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
Hot Reload memperbarui tampilan aplikasi secara instan tanpa menghapus state, sehingga cocok untuk menguji perubahan desain dan UI dengan cepat.
Hot Restart menjalankan ulang seluruh aplikasi dari awal dan menghapus state, cocok digunakan ketika ada perubahan besar pada logika, struktur widget, atau variabel global.


</details>

<details>
<summary> Tugas 8</summary> 

**1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?**

`Navigator.push()`
Fungsi ini menambahkan halaman baru ke tumpukan (stack) navigator tanpa menghapus halaman sebelumnya.
Jadi saat pengguna menekan tombol “Back”, ia akan kembali ke halaman sebelumnya. Biasanya dipakai untuk navigasi normal antar halaman seperti dari beranda ke form tambah produk.

`Navigator.pushReplacement()`
Fungsi ini mengganti halaman saat ini dengan halaman baru, sehingga halaman sebelumnya dihapus dari stack. Jadi tombol “Back” tidak akan membawa pengguna ke halaman sebelumnya. Cocok untuk transisi permanen seperti setelah login/logout.

**2. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?**

<li> Scaffold </li>
Sebagai kerangka utama halaman yang menyediakan struktur dasar: AppBar, Drawer, dan Body. SCaffold juga memastikan semua halaman memiliki tampilan yang seragam
<li> Appbar </li>
Menampilkan judul halaman dan memberikan konteks pada pengguna.

<li> Drawer </li>
Berfungsi sebagai navigasi global, memungkinkan pengguna berpindah antar halaman (beranda, tambah produk, logout).

Kamu sudah menerapkannya di LeftDrawer() agar konsisten di seluruh halaman.

**3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.**
`Padding`
Memberi jarak antar elemen agar UI tidak terlihat menumpuk, meningkatkan kenyamanan visual dan keterbacaan form.

`SingleChildScrollView`
Membuat halaman bisa di-scroll jika tinggi konten melebihi layar.

`ListView`
Digunakan untuk menampilkan daftar elemen dinamis, misalnya daftar produk atau berita.

Mendukung scrolling otomatis tanpa perlu SingleChildScrollView.

**4. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?**
Untuk saat ini, penyesuaian warna tema aplikasi belum sepenuhnya disinkronkan dengan brand toko berbasis web,NewGames Shop. Warna default Flutter masih digunakan (biru standar Colors.blue), sehingga belum menggambarkan identitas visual toko secara menyeluruh.
Langkah selanjutnya yang akan  saya lakukan adalah menyesuaikan warna utama (primary) dan warna aksen (secondary) di ThemeData agar konsisten dengan brand di website yaitu gradasi biru dan oranye yang menjadi ciri khas NewGames Shop.

</details>