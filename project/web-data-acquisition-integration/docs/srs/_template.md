# Template SRS

Salin ke: `docs/srs/{project-name}/SRS-{module}-v1.0.0.md`

---

# SRS — {Nama Modul}

Version: 1.0.0
Status: Draft
Author: business-analyst, system-analyst
Last Updated: {YYYY-MM-DD}
Project: {project-name}

---

## 1. Pendahuluan

### 1.1 Tujuan

{Jelaskan tujuan dokumen SRS ini}

### 1.2 Ruang Lingkup

**In Scope:**
- {fitur yang termasuk}

**Out of Scope:**
- {fitur yang tidak termasuk}

### 1.3 Definisi & Singkatan

| Istilah | Definisi |
|---------|----------|
| {istilah} | {definisi} |

### 1.4 Referensi

| Dokumen | Lokasi |
|---------|--------|
| Product Requirement | docs/planning/roadmap.md |
| User Story | — |

---

## 2. Gambaran Umum

### 2.1 Perspektif Produk

{Posisi modul dalam sistem keseluruhan}

### 2.2 Fungsi Produk

{Ringkasan fungsi utama modul}

### 2.3 Karakteristik Pengguna

| Role | Deskripsi | Hak Akses |
|------|-----------|-----------|
| {role} | {deskripsi} | {akses} |

### 2.4 Batasan

- {batasan teknis/bisnis}

### 2.5 Asumsi & Ketergantungan

- {asumsi}
- {ketergantungan ke modul lain}

---

## 3. Kebutuhan Fungsional

| ID | Requirement | Prioritas | Acceptance Criteria |
|----|-------------|-----------|---------------------|
| FR-001 | {requirement} | Critical | {AC yang dapat diuji} |
| FR-002 | {requirement} | High | {AC yang dapat diuji} |

---

## 4. Kebutuhan Non-Fungsional

| ID | Kategori | Requirement |
|----|----------|-------------|
| NFR-001 | Security | {requirement} |
| NFR-002 | Performance | {requirement} |

---

## 5. Business Rules

| ID | Rule | Sumber |
|----|------|--------|
| BR-001 | {aturan bisnis} | Product Owner |

---

## 6. Use Case

### UC-001 — {Nama Use Case}

| Field | Value |
|-------|-------|
| ID | UC-001 |
| Actor | {actor} |
| Priority | Critical |
| Related FR | FR-001 |

**Preconditions:**
- {kondisi sebelum use case dimulai}

**Main Flow:**
1. {langkah}
2. {langkah}
3. {langkah}

**Alternative Flow:**
- {AF-1}: {deskripsi}

**Exception Flow:**
- {EF-1}: {deskripsi error dan response}

**Postconditions:**
- {kondisi setelah use case selesai}

---

## 7. System Flow

```
Request → Validation → Authorization → Business Logic → Database → Response
```

{Detail flow per fitur jika diperlukan}

---

## 8. Data Requirement

| Entity | Field | Type | Required | Rule |
|--------|-------|------|----------|------|
| {entity} | {field} | {type} | Yes/No | {rule} |

---

## 9. API Requirement

| ID | Method | Endpoint | Auth | Description |
|----|--------|----------|------|-------------|
| API-001 | POST | /api/v1/{resource} | Yes | {deskripsi} |

### API-001 Detail

**Request:**
```json
{
  "field": "value"
}
```

**Response Success:**
```json
{
  "success": true,
  "message": "string",
  "data": {},
  "errors": null
}
```

**Error Response:**
| Code | Condition |
|------|-----------|
| 422 | Validation failed |
| 401 | Unauthorized |

---

## 10. Integration Requirement

| ID | System | Direction | Data |
|----|--------|-----------|------|
| INT-001 | {system eksternal} | Outbound | {data} |

---

## 11. Validation Rule

| Field | Rule | Error Message |
|-------|------|---------------|
| email | required, email format | Email tidak valid |

---

## 12. Exception Handling

| Code | Scenario | User Message | System Action |
|------|----------|--------------|---------------|
| ERR-001 | Data not found | Data tidak ditemukan | Return 404 |

---

## 13. Traceability Matrix

| Requirement | Use Case | Module | Task ID | Status |
|-------------|----------|--------|---------|--------|
| FR-001 | UC-001 | {module} | TASK-001 | Planned |

---

## 14. Approval

| Role | Agent | Status | Date |
|------|-------|--------|------|
| Product Owner | product-owner | Pending | — |
| System Analyst | system-analyst | Pending | — |
| Technical Writer | technical-writer | Pending | — |
