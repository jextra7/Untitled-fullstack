# Hunter RPG Game

Game RPG sederhana berbasis text dengan tema hunter yang mendapatkan reawakening dari rank F menjadi kuat. Dibangun menggunakan Motoko untuk backend di Internet Computer dan HTML/JavaScript untuk frontend.

## 📋 Deskripsi

Kamu bermain sebagai seorang hunter rank F yang lemah dan sering diremehkan. Setelah gagal dalam dungeon run, kamu terbangun di rumah sakit dan mendapat kesempatan untuk reawakening. Pilihan yang kamu buat akan menentukan jalur cerita dan ending yang berbeda.

### 🎮 Fitur Game

- **Multiple Paths**: 2 jalur utama (Fighter/Mage) dengan 6 spesialisasi
- **Branching Story**: Cerita bercabang dengan 18+ ending berbeda
- **Stats System**: Sistem statistik (Strength, Intelligence, Luck)
- **Progress Tracking**: Pelacakan progress dan jalur cerita
- **Interactive UI**: Interface dengan tombol aksi yang dinamis

### 🗂️ Struktur Cerita

```
Start (Hunter Rank F)
├── Pergi Latihan → Fighter Path
│   ├── Berserker → 3 endings
│   ├── Guardian → 3 endings
│   └── Assassin → 3 endings
├── Baca Buku → Mage Path
│   ├── Elementalist → 3 endings
│   ├── Healer → 3 endings
│   └── Summoner → 3 endings
└── Menyerah → Civilian ending
```

## 🚀 Cara Menjalankan

### Opsi 1: Menggunakan icp.ninja (Recommended)

1. **Deploy Backend:**
   - Buka [https://icp.ninja/](https://icp.ninja/)
   - Pilih tab "Motoko"
   - Copy paste kode dari `rpg_game.mo`
   - Klik "Compile" lalu "Deploy"
   - Catat Canister ID yang muncul

2. **Setup Frontend:**
   - Buka file `frontend.html`
   - Ganti `YOUR_CANISTER_ID_HERE` dengan Canister ID dari step 1
   - Buka file HTML di browser

3. **Alternatif Testing:**
   - Gunakan tab "Candid UI" di icp.ninja untuk testing langsung
   - Panggil fungsi `startGame("NamaPemain")`
   - Lanjutkan dengan `playerAction("aksi")`

### Opsi 2: Local Development

1. **Install Dependencies:**
   ```bash
   # Install DFINITY SDK
   sh -ci "$(curl -fsSL https://smartcontracts.org/install.sh)"
   ```

2. **Create Project:**
   ```bash
   dfx new hunter_rpg
   cd hunter_rpg
   ```

3. **Replace Files:**
   - Copy `rpg_game.mo` ke `src/hunter_rpg/main.mo`
   - Setup frontend sesuai kebutuhan

4. **Deploy:**
   ```bash
   dfx start --background
   dfx deploy
   ```

## 🎯 Cara Bermain

### 1. Mulai Game
- Masukkan nama hunter
- Klik "Mulai Game"

### 2. Pilih Jalur Awal
- **🏋️ Pergi Latihan**: Menjadi Fighter (STR +5)
- **📚 Baca Buku Magic**: Menjadi Mage (INT +5)
- **😞 Menyerah**: Ending langsung

### 3. Pilih Spesialisasi

**Fighter Path:**
- **⚔️ Berserker**: High attack, solo fighter (STR +10)
- **🛡️ Guardian**: Balanced, team player (STR +5, INT +3, LUCK +2)
- **🗡️ Assassin**: Speed & luck focus (STR +3, INT +2, LUCK +5)

**Mage Path:**
- **🔥 Elementalist**: Pure magic damage (INT +10)
- **💚 Healer**: Support & luck (INT +5, LUCK +5)
- **👹 Summoner**: Summon creatures (STR +2, INT +8)

### 4. Final Choice & Ending
Setiap spesialisasi memiliki 3 pilihan akhir yang menentukan ending:
- Solo approach vs Team approach vs Strategic approach

## 📁 File Structure

```
d:/Motoko/
├── rpg_game.mo      # Backend Motoko canister
├── frontend.html    # Frontend web interface
└── README.md        # Dokumentasi ini
```

## 🔧 API Functions

### Backend (Motoko)

```motoko
// Mulai game baru
startGame(name: Text) -> Text

// Ambil cerita saat ini
getStory() -> Text

// Lakukan aksi pemain
playerAction(action: Text) -> Text

// Lihat statistik pemain
getStats() -> Text
```

### Frontend (JavaScript)

```javascript
// Fungsi utama
startGame()           // Mulai game
performAction(action) // Lakukan aksi
getStats()           // Tampilkan stats
restartGame()        // Restart game
```

## 🎨 Customization

### Menambah Cerita Baru

1. **Backend** (`rpg_game.mo`):
   ```motoko
   // Tambah di fungsi playerAction
   else if (s.progress == 3 and s.path == "new_path") {
     // Logic cerita baru
   }
   ```

2. **Frontend** (`frontend.html`):
   ```javascript
   // Tambah di showActionButtons dan simulateComplexAction
   else if (progress === 3 && path === "new_path") {
     // UI dan logic baru
   }
   ```

### Menambah Stats Baru

```motoko
// Di type GameState
stats: {
  strength: Nat;
  intelligence: Nat;
  luck: Nat;
  newStat: Nat;  // Tambah stat baru
};
```

## 🐛 Troubleshooting

### Game Stuck Setelah Pilihan Class
- Pastikan frontend dan backend logic konsisten
- Check apakah `gameState.path` diupdate dengan benar

### Error Saat Deploy di icp.ninja
- Hapus canister lama jika ada perubahan struktur data
- Pastikan tidak ada syntax error di kode Motoko

### Frontend Tidak Terhubung ke Canister
- Pastikan Canister ID benar di `frontend.html`
- Check network connection ke IC mainnet

## 📝 License

MIT License - Feel free to modify and distribute.

## 🤝 Contributing

1. Fork repository
2. Create feature branch
3. Make changes
4. Test thoroughly
5. Submit pull request

## 📞 Support

Jika ada pertanyaan atau bug, silakan:
-
