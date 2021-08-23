# SIMRS Clinical Review — Checklist

Dipakai bersama skill `simrs-clinical-review` dan `simrs-hospital-ops`.

## Matriks aksi vs peran (default deny)

Tandai **Fail** jika UI/API mengizinkan tanpa waiver tertulis RS.

| Aksi | Dokter / DPJP | Perawat | Pendaftaran | Farmasi | Kasir | RM | Sysadmin |
|------|---------------|---------|-------------|---------|-------|-----|----------|
| Ubah identitas pasien | terbatas + audit | tidak | ya + audit | tidak | tidak | terbatas | tidak (kecuali prosedur) |
| SOAP / diagnosa medis | ya | tidak | tidak | tidak | tidak | tidak | tidak |
| TTV / askep | baca | ya | tidak | tidak | tidak | baca sesuai kebijakan | tidak |
| Order lab/rad | ya | sesuai protokol | tidak | tidak | tidak | tidak | tidak |
| Input hasil lab | tidak | tidak | tidak | tidak | tidak | tidak | tidak (analis / dokter PK) |
| Resep | ya | tidak | tidak | verifikasi/serah | tidak | tidak | tidak |
| Stok / dispensing | tidak | serah ruangan | tidak | ya | tidak | tidak | tidak |
| Tarif / bayar | tidak | tidak | tidak | tidak | ya | tidak | master tarif |
| Closing pulang ranap | DPJP | persiapan | tidak | resep pulang | tagihan | berkas | tidak |
| Hapus kunjungan | tidak | tidak | terbatas + audit | tidak | tidak | terbatas | tidak |

## Walkthrough wajib (pilih sesuai scope)

### A. Rawat jalan

- [ ] Cari pasien lama vs daftar baru tidak membuat RM duplikat tanpa peringatan
- [ ] Pilih poli + dokter + ruangan; antrian muncul di poli yang sama
- [ ] Perawat isi TTV; dokter isi SOAP; perawat **tidak** bisa ganti diagnosa primer
- [ ] Order lab tertambat ke kunjungan; hasil kembali ke worklist dokter
- [ ] Resep hanya dari kunjungan terbuka; farmasi melihat antrian resep
- [ ] Kasir hanya item dari pelayanan itu; batal tindakan menarik tagihan

### B. IGD

- [ ] Triase bisa dimulai tanpa NIK lengkap, lalu dilengkapi
- [ ] Status P1 tidak antre di belakang P3 tanpa alasan
- [ ] Rujuk ranap: kamar + DPJP + serah terima; kunjungan IGD tidak “hilang”

### C. Rawat inap

- [ ] Worklist ter-filter ruangan hak user
- [ ] Ganti kamar mengubah akomodasi, bukan menghapus riwayat
- [ ] CPPT berurutan; edit punya jejak
- [ ] Pulang menuntut resume (jika kebijakan RS); bed kembali tersedia

### D. Akses & menu

- [ ] Kartu modul di beranda = `aksespengguna` aktif
- [ ] Sidebar = `peranpengguna_akses` terisi, bukan array kosong
- [ ] Picker ruangan = `ruanganpemakai` ∩ instalasi modul
- [ ] Superadmin lokal: modul + menu + ruangan — bukan hanya login

## Format temuan

```text
[P0|P1|P2] Modul / layar
Peran: …
Prasyarat: …
Yang terjadi: …
Seharusnya: … (alur RS)
Dampak: …
Bukti: path / langkah (tanpa PHI)
```

## Verdict

- **Reject** — rantai RM/kunjungan putus, atau role klinis bisa aksi finansial/klinis yang dilarang
- **Request changes** — journey utama jalan, RBAC atau side-effect bolong
- **Approve** — walkthrough scope lulus, sisa P2 tidak memblokir pelayanan
