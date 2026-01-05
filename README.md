# Laporan Tugas Besar  
### Kuliah Desain FPGA dan SoC  

**Kelompok 6** :  
**Komang Sadhu Mahaputra - 1102223256** :  
**Muhammad Ferdiansyah - 1102223233** :  
**Muhammad Naufal Hafidz - 1102223250** :  
**Ashura Sindhu Santhana - 1102223224** :  

---

# Judul  
**PERANCANGAN DAN IMPLEMENTASI KALKULATOR ARITMETIKA FIXED-POINT 4-BIT BERBASIS FPGA**
---

# Deskripsi 
Kalkulator aritmetika fixed-point 4-bit berbasis FPGA merupakan sebuah sistem digital yang menerima dua buah bilangan bertanda dalam format fixed-point Q2.2, kemudian memprosesnya menggunakan operasi penjumlahan, pengurangan, perkalian, dan pembagian. Pemilihan operasi dilakukan melalui sinyal kontrol berupa switch atau push button, sedangkan hasil perhitungan ditampilkan dalam bentuk karakter heksadesimal pada 7-segment display. Sistem ini dirancang untuk memberikan pemahaman mengenai implementasi aritmetika fixed-point dan pemrosesan paralel pada FPGA.

Desain mencakup:  
- FSM   
- Testbench & simulasi ModelSim  
- Implementasi hardware pada DE1-SoC  

---

# Fungsi 
- Meningkatkan pemahaman mengenai implementasi logika digital berbasis FPGA.
- Menambah pengalaman dalam perancangan dan pemrograman perangkat keras menggunakan bahasa Hardware Description Language (HDL).
- Memberikan pemahaman mengenai sistem representasi bilangan fixed-point dan penerapannya dalam aritmetika digital.
- Mengembangkan keterampilan melakukan simulasi dan verifikasi sistem digital hingga implementasi pada perangkat keras nyata.


---

# Fitur dan Spesifikasi  
[jelaskan fitur yang dimiliki oleh tugas besar yang akan dibuat]

## **Fitur**
- Mendeteksi pola biner **101**  
- Respons deteksi lebih cepat karena Mealy Machine  
- Mendukung *overlapping detection*, contoh:  
  - Input `10101` menghasilkan dua kali deteksi  
- Input dari switch FPGA  
- Output berupa LED indikator  

## **Spesifikasi**
- Input bit dari **SW & KEY**  
- Clock 50 MHz internal FPGA  
- Output aritmatika pada **7segment**   
- Implementasi Verilog HDL  
- Simulasi menggunakan ModelSim  
- FPGA: DE1-SoC (Cyclone V)  

---

# Cara Penggunaan  
[Bisa dalam bentuk flowchart agar lebih mudah dimengerti, bisa dalam bentuk poin – poin penjelasan]

### **Langkah-langkah**
1. Kompilasi desain di Quartus dan download file `.sof` ke FPGA.  
2. Berikan input bit menggunakan **SW0**.  
3. Tekan **KEY0** untuk memberikan clock (jika digunakan mode step clock).  
4. Output HIGH akan muncul pada **LED0** jika pola **101** muncul dalam urutan input.  

### **Flowchart**

# Blok Diagram  
[Menggambarkan blok-blok yang digunakan, diberi paragraf penjelasan kegunaan dan input output setiap blok]
// ini contoh 
<img width="629" height="250" alt="image" src="https://github.com/user-attachments/assets/7992a6ba-355d-429f-aa73-e2f0b3810c51" />


# FSM 
[Menjelaskan cara kerja dan transisi dalam FSM]

### Penjelasan Blok  
- **Input Handler**: Mengambil bit dari switch dan mengirimkan ke FSM.  
- **Mealy FSM Detector**: Memproses input & state, menghasilkan output langsung jika pola ditemukan.  
- **Output Driver**: Mengatur LED indikator deteksi pola.

---

# FSM (Mealy Machine)

FSM dirancang untuk mendeteksi pola **101**.

### **State (3 state Mealy)**
- **S0** – Belum menerima bagian pola  
- **S1** – Menerima ‘1’  
- **S2** – Menerima ‘10’  

<img width="303" height="181" alt="image" src="https://github.com/user-attachments/assets/104a3f8d-a7dc-47b0-80a0-106e2b8adeb8" />

### **Tabel Transisi FSM Mealy (Pola 101)**

<img width="762" height="200" alt="image" src="https://github.com/user-attachments/assets/a1bb5e9f-f80b-4ba2-b9f5-dbbbe2acc1b9" />


**Output terjadi saat transisi dari S2 dengan input = 1.**

---
# Hasil simulasi dan Analisis

<img width="987" height="309" alt="image" src="https://github.com/user-attachments/assets/efde1792-d3a6-45a0-9703-f3ae64677cb1" />

Waveform menunjukkan bahwa clock dan input bekerja normal dengan reset = 0 sehingga FSM aktif. Saat input din membentuk urutan 1 → 0 → 1, FSM bergerak melalui state S0 → S1 → S2 → S1. Pada saat FSM berada di S2 dan menerima input 1, output dout menjadi HIGH selama satu siklus clock. Hal ini menandakan bahwa pola 101 berhasil terdeteksi tepat pada transisi yang sesuai dengan karakter Mealy Machine (output muncul berdasarkan state + input). Setelah deteksi, FSM kembali ke state S1 sehingga overlapping dapat dideteksi pada urutan berikutnya. Secara keseluruhan, waveform menunjukkan bahwa sequence detector Mealy 101 berjalan sesuai desain dan berfungsi dengan benar.

# Lampiran (Kode Verilog)
Kode Verilog ada di sini: [mealy_101.v](src/mealy_101.v) 
File test: [mealy_101_tb.v](src/mealy_101_tb.v) 

# Link Video Implementasi

[masukan link video progress atau hasil yang telah berhasil diimplementasikan kehardware]
