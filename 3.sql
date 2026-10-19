---Query Kompleks & Agregasi Laporan---
SELECT z.nama_zona, COUNT(l.id_laporan) AS total_laporan
FROM laporan l
JOIN zona_lahan z ON l.id_zona = z.id_zona
WHERE l.tanggal_laporan >= '2026-10-01'
GROUP BY z.id_zona, z.nama_zona;

---Alur Eksekusi---
1. **JOIN: setiap laporan dihubungkan dengan nama zonanya.
2. **WHERE**: hanya laporan yang bertanggal sesuai filter yang diproses.
3. **GROUP BY**: laporan dikelompokkan per zona.
4. **SELECT**: `COUNT()` menghitung jumlah laporan di tiap kelompok.
