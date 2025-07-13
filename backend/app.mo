// Cara menjalankan di icp.ninja:
// 1. Buka https://icp.ninja/
// 2. Pilih tab "Motoko".
// 3. Salin seluruh kode ini ke editor Motoko di icp.ninja.
// 4. Klik "Compile".
// 5. Gunakan tab "Candid UI" untuk memanggil fungsi startGame, getStory, dan playerAction.

import Nat "mo:base/Nat";
import Text "mo:base/Text";

actor RPGGame {
  type GameState = {
    playerName: Text;
    story: Text;
    progress: Nat;
    path: Text;
    stats: {
      strength: Nat;
      intelligence: Nat;
      luck: Nat;
    };
  };

  var state: ?GameState = null;

  public func startGame(name: Text): async Text {
    state := ?{
      playerName = name;
      story = "Kamu adalah seorang hunter rank F yang lemah dan sering diremehkan. Suatu hari, kamu terbangun di rumah sakit setelah dungeon run gagal. Apa yang akan kamu lakukan? (pilih: 'pergi latihan', 'baca buku', atau 'menyerah')";
      progress = 0;
      path = "";
      stats = { strength = 10; intelligence = 10; luck = 10; };
    };
    return switch (state) {
      case (?s) { s.story };
      case null { "Gagal memulai game." };
    };
  };

  public func getStory(): async Text {
    switch (state) {
      case (?s) { s.story };
      case null { "Game belum dimulai. Mulai dengan startGame(nama)." };
    }
  };

  public func playerAction(action: Text): async Text {
    switch (state) {
      case (?s) {
        var nextStory : Text = "";
        var newPath = s.path;
        var newStats = s.stats;
        
        // Progress 0: Pilihan awal yang menentukan jalur
        if (s.progress == 0) {
          if (action == "pergi latihan") {
            newPath := "fighter";
            newStats := { strength = s.stats.strength + 5; intelligence = s.stats.intelligence; luck = s.stats.luck; };
            nextStory := "Kamu berlatih keras. Saat latihan, notifikasi muncul: 'Reawakening Fighter Type!'. Pilih spesialisasi: ('berserker', 'guardian', atau 'assassin')";
          } else if (action == "baca buku") {
            newPath := "mage";
            newStats := { strength = s.stats.strength; intelligence = s.stats.intelligence + 5; luck = s.stats.luck; };
            nextStory := "Kamu membaca buku magic theory. Notifikasi muncul: 'Reawakening Mage Type!'. Pilih spesialisasi: ('elementalist', 'healer', atau 'summoner')";
          } else if (action == "menyerah") {
            newPath := "civilian";
            nextStory := "Kamu menyerah dan hidup normal. Tapi nasib berkata lain... (Game Selesai - Ending Biasa)";
          };
        }
        
        // Progress 1: Spesialisasi Fighter
        else if (s.progress == 1 and s.path == "fighter") {
          if (action == "berserker") {
            newPath := "berserker";
            newStats := { strength = s.stats.strength + 10; intelligence = s.stats.intelligence; luck = s.stats.luck; };
            nextStory := "Kamu menjadi Berserker! Kekuatan fisikmu meningkat drastis. Ada dungeon S-rank yang muncul. Pilih: ('serang langsung', 'strategi', atau 'cari bantuan')";
          } else if (action == "guardian") {
            newPath := "guardian";
            newStats := { strength = s.stats.strength + 5; intelligence = s.stats.intelligence + 3; luck = s.stats.luck + 2; };
            nextStory := "Kamu menjadi Guardian! Kamu dapat melindungi orang lain. Tim hunter meminta bantuanmu. Pilih: ('terima misi', 'tolak', atau 'negosiasi')";
          } else if (action == "assassin") {
            newPath := "assassin";
            newStats := { strength = s.stats.strength + 3; intelligence = s.stats.intelligence + 2; luck = s.stats.luck + 5; };
            nextStory := "Kamu menjadi Assassin! Kecepatan dan keberuntunganmu tinggi. Ada misi rahasia. Pilih: ('terima misi', 'investigasi dulu', atau 'tolak')";
          };
        }
        
        // Progress 1: Spesialisasi Mage
        else if (s.progress == 1 and s.path == "mage") {
          if (action == "elementalist") {
            newPath := "elementalist";
            newStats := { strength = s.stats.strength; intelligence = s.stats.intelligence + 10; luck = s.stats.luck; };
            nextStory := "Kamu menguasai magic elemen! Ada ancient dungeon dengan magic seal. Pilih: ('buka seal', 'pelajari dulu', atau 'cari wizard lain')";
          } else if (action == "healer") {
            newPath := "healer";
            newStats := { strength = s.stats.strength; intelligence = s.stats.intelligence + 5; luck = s.stats.luck + 5; };
            nextStory := "Kamu menjadi Healer langka! Guild membutuhkan bantuanmu untuk raid besar. Pilih: ('gabung raid', 'minta bayaran tinggi', atau 'tolak')";
          } else if (action == "summoner") {
            newPath := "summoner";
            newStats := { strength = s.stats.strength + 2; intelligence = s.stats.intelligence + 8; luck = s.stats.luck; };
            nextStory := "Kamu dapat memanggil monster! Ada kontrak dengan Ancient Dragon. Pilih: ('terima kontrak', 'negosiasi', atau 'tolak')";
          };
        }
        
        // Progress 2: Ending berdasarkan path
        else if (s.progress == 2) {
          if (s.path == "berserker") {
            if (action == "serang langsung") {
              nextStory := "Kamu menyerang dungeon sendirian dan berhasil! Kamu menjadi Legend Berserker! (Ending: Solo Legend)";
            } else if (action == "strategi") {
              nextStory := "Kamu menggunakan strategi dan berhasil dengan mudah. Kamu menjadi Tactical Berserker! (Ending: Smart Fighter)";
            } else if (action == "cari bantuan") {
              nextStory := "Kamu membentuk tim dan sukses bersama. Kamu menjadi Leader Berserker! (Ending: Team Leader)";
            };
          } else if (s.path == "guardian") {
            if (action == "terima misi") {
              nextStory := "Kamu menyelamatkan tim dan menjadi Hero Guardian! (Ending: Hero Guardian)";
            } else if (action == "tolak") {
              nextStory := "Kamu fokus self-improvement dan menjadi Perfect Guardian! (Ending: Perfect Defense)";
            } else if (action == "negosiasi") {
              nextStory := "Kamu bernegosiasi dan menjadi Diplomat Guardian! (Ending: Peace Keeper)";
            };
          } else if (s.path == "assassin") {
            if (action == "terima misi") {
              nextStory := "Kamu menerima misi rahasia dan berhasil sempurna! Kamu menjadi Shadow Master! (Ending: Shadow Legend)";
            } else if (action == "investigasi dulu") {
              nextStory := "Kamu menyelidiki misi dan menemukan konspirasi besar. Kamu menjadi Truth Seeker! (Ending: Dark Detective)";
            } else if (action == "tolak") {
              nextStory := "Kamu menolak dan fokus pada misi sendiri. Kamu menjadi Lone Wolf! (Ending: Solo Assassin)";
            };
          } else if (s.path == "elementalist") {
            if (action == "buka seal") {
              nextStory := "Kamu membuka seal dan mendapat ancient magic! Kamu menjadi Archmage! (Ending: Ancient Power)";
            } else if (action == "pelajari dulu") {
              nextStory := "Kamu mempelajari magic dengan hati-hati dan menjadi Wise Elementalist! (Ending: Wisdom Path)";
            } else if (action == "cari wizard lain") {
              nextStory := "Kamu bekerja sama dengan wizard lain dan menjadi Magic Council Leader! (Ending: Magic Alliance)";
            };
          } else if (s.path == "healer") {
            if (action == "gabung raid") {
              nextStory := "Kamu bergabung dengan raid dan menyelamatkan semua anggota! Kamu menjadi Saint Healer! (Ending: Divine Savior)";
            } else if (action == "minta bayaran tinggi") {
              nextStory := "Kamu menjadi healer eksklusif untuk guild elit. Kamu menjadi Premium Healer! (Ending: Elite Medic)";
            } else if (action == "tolak") {
              nextStory := "Kamu fokus membantu rakyat biasa dan menjadi People's Healer! (Ending: Folk Hero)";
            };
          } else if (s.path == "summoner") {
            if (action == "terima kontrak") {
              nextStory := "Kamu menandatangani kontrak dengan Ancient Dragon! Kamu menjadi Dragon Lord! (Ending: Dragon Master)";
            } else if (action == "negosiasi") {
              nextStory := "Kamu bernegosiasi dan mendapat kontrak yang lebih baik. Kamu menjadi Contract Master! (Ending: Smart Summoner)";
            } else if (action == "tolak") {
              nextStory := "Kamu menolak dan mencari familiar sendiri. Kamu menjadi Independent Summoner! (Ending: Free Spirit)";
            };
          };
        }
        
        // Default case
        else {
          nextStory := "Cerita berakhir. Stats akhir - STR: " # Nat.toText(s.stats.strength) # ", INT: " # Nat.toText(s.stats.intelligence) # ", LUCK: " # Nat.toText(s.stats.luck);
        };
        
        state := ?{
          playerName = s.playerName;
          story = nextStory;
          progress = s.progress + 1;
          path = newPath;
          stats = newStats;
        };
        nextStory
      };
      case null { "Game belum dimulai." };
    }
  };

  // Fungsi baru untuk cek stats
  public query func getStats(): async Text {
    switch (state) {
      case (?s) { 
        "Stats " # s.playerName # " (Path: " # s.path # ") - STR: " # Nat.toText(s.stats.strength) # ", INT: " # Nat.toText(s.stats.intelligence) # ", LUCK: " # Nat.toText(s.stats.luck)
      };
      case null { "Game belum dimulai." };
    }
  };
}