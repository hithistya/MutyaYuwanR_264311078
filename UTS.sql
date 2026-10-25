-- ---------------------------------------------------------------------
-- A. ALASAN BISNIS
-- ---------------------------------------------------------------------
-- Sistem perlu mendeteksi pengukuran yang melewati ambang batas
-- (misalnya pH terlalu asam atau suhu terlalu tinggi). Agar konsisten,
-- ambang batas (nilai_min, nilai_max) dikelola terpusat pada master
-- jenis_sensor, sehingga semua sensor sejenis memakai aturan yang sama.
 
-- ---------------------------------------------------------------------
-- B. ANALISIS NORMALISASI
-- ---------------------------------------------------------------------
-- Tabel lama:
--   sensor(id_sensor, id_zona, nama_sensor, jenis_sensor,
--          status_sensor, satuan)
--
-- 1NF : Semua atribut atomik dan setiap baris diidentifikasi oleh
--       id_sensor. TERPENUHI.
--
-- 2NF : Primary key tunggal (id_sensor), sehingga tidak ada
--       ketergantungan parsial. TERPENUHI.
--
-- 3NF : TIDAK terpenuhi. Terdapat ketergantungan transitif:
--           id_sensor -> jenis_sensor -> satuan
--       Satuan ditentukan oleh jenis sensor, bukan oleh sensornya,
--       sehingga "Suhu Udara = °C" tertulis berulang di setiap sensor
--       suhu (rawan anomali update dan data tidak konsisten).
--
-- Solusi: atribut yang bergantung pada jenis dipisahkan ke tabel baru.
--   jenis_sensor(id_jenis, nama_jenis, satuan, nilai_min, nilai_max)
--   sensor(id_sensor, id_zona, id_jenis, nama_sensor, status_sensor)
--
-- Hasil: setiap atribut non-key hanya bergantung pada primary key
-- tabelnya sendiri. 3NF TERPENUHI.
-- Relasi: JENIS_SENSOR (1) ---- (N) SENSOR
 
-- ---------------------------------------------------------------------
-- C. DDL 
-- ---------------------------------------------------------------------
 
-- Tabel jenis_sensor
CREATE TABLE `jenis_sensor` (
  `id_jenis`   int NOT NULL AUTO_INCREMENT,
  `nama_jenis` varchar(50) NOT NULL,
  `satuan`     varchar(20) NOT NULL,
  `nilai_min`  decimal(10,2) NOT NULL,
  `nilai_max`  decimal(10,2) NOT NULL,
  CONSTRAINT `chk_ambang_batas` CHECK (`nilai_min` < `nilai_max`)
) 
 
-- Tabel sensor (struktur baru)
CREATE TABLE `sensor` (
  `id_sensor`     int NOT NULL AUTO_INCREMENT,
  `id_zona`       int NOT NULL,
  `id_jenis`      int NOT NULL,
  `nama_sensor`   varchar(100) NOT NULL,
  `status_sensor` varchar(30) NOT NULL,
  PRIMARY KEY (`id_sensor`),
  KEY `fk_sensor_zona` (`id_zona`),
  KEY `fk_sensor_jenis` (`id_jenis`),
  KEY `idx_sensor_status` (`status_sensor`),
  CONSTRAINT `fk_sensor_zona` FOREIGN KEY (`id_zona`)
    REFERENCES `zona_lahan` (`id_zona`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `fk_sensor_jenis` FOREIGN KEY (`id_jenis`)
    REFERENCES `jenis_sensor` (`id_jenis`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `chk_status_sensor` CHECK (`status_sensor` IN ('Aktif','Perawatan','Nonaktif'))
) 
 
-- ---------------------------------------------------------------------
-- D. DATA
-- ---------------------------------------------------------------------
 
-- Data jenis sensor
INSERT INTO `jenis_sensor` (`id_jenis`, `nama_jenis`, `satuan`, `nilai_min`, `nilai_max`) VALUES
(1, 'Kelembaban Tanah', '%',  40.00, 80.00),
(2, 'Suhu Udara',       '°C', 20.00, 35.00),
(3, 'pH Tanah',         'pH',  5.50,  7.50);
 
-- Data sensor
INSERT INTO `sensor` (`id_sensor`, `id_zona`, `id_jenis`, `nama_sensor`, `status_sensor`) VALUES
(1, 1, 1, 'Sensor Kelembaban A1', 'Aktif'),
(2, 1, 2, 'Sensor Suhu A1',       'Aktif'),
(3, 2, 3, 'Sensor pH B1',         'Aktif'),
(4, 2, 1, 'Sensor Kelembaban B1', 'Perawatan'),
(5, 3, 2, 'Sensor Suhu C1',       'Aktif');
