# Frontend Engineering — Reference

## State model

- Server state vs UI state dipisah secara jelas
- Derivation daripada duplikasi state
- Optimistic UI hanya dengan rollback path

## Forms & tables

- Label terasosiasi; error inline; disable submit saat busy
- Tabel: kolom No. bila list paginated; kontrol halaman jelas
- Jangan card dekoratif tanpa interaksi (lihat rule `ui`)

## Modal / overlay

- Portal/stacking context; scroll lock; fokus restore
- Jangan geser layout di belakang; tutup on Escape bila pola project mengizinkan

## Performance

- Evitasi list tanpa virtualisasi/pagination
- Image/media: ukuran & lazy sesuai kebutuhan
- Bundle: code-split route berat

## Anti-patterns

- Fetch di dalam tight loop tanpa cache
- Ignore error boundary / silent failure
- Inline style chaos yang melawan design tokens
