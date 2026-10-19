---Tabel pengguna---
INSERT INTO pengguna (id_pengguna, nama_pengguna, username, password, role, email, no_telp) VALUES
(1, 'Budi', 'budi123', 'budi123', 'Admin_Sistem', 'budi@mail.com', '081234567890'),
(2, 'Anis', 'anis123', 'anis123', 'Petugas_Lapangan', 'anis@mail.com', '081298765432'),
(3, 'Dewi', 'dewi123', 'dewi123', 'Koordinator', 'dewi@mail.com', '081355511122');

---Tabel zona_lahan---
INSERT INTO zona_lahan (id_zona, nama_zona, luas_lahan, jenis_tanaman) VALUES
(1, 'Zona A', 2.50, 'Padi'),
(2, 'Zona B', 1.75, 'Jagung'),
(3, 'Zona C', 3.20, 'Cabai'),

---Tabel laporan---
INSERT INTO laporan (id_laporan, id_zona, id_pengguna, tanggal_laporan, ringkasan, rekomendasi) VALUES
(1, 1, 2, '2026-10-10', 'Kelembapan tanah stabil', 'Pertahankan jadwal irigasi'),
(2, 2, 2, '2026-10-12', 'Suhu cenderung tinggi', 'Tambah frekuensi penyiraman'),
(3, 1, 3, '2026-10-15', 'Ada peringatan kelembapan rendah', 'Lakukan penyiraman tambahan');

--- Read ---
SELECT * FROM zona_lahan;

--- Update ----
UPDATE laporan
SET rekomendasi = 'Lakukan penyiraman tambahan dan cek ulang sensor'
WHERE id_laporan = 3;

--- Delete ---
DELETE FROM laporan
WHERE id_laporan = 2;

