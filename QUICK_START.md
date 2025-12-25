# ⚡ Quick Start Guide - TTS Fix

## 🚨 The Problem
**Cell 8 produces garbage audio!** 

The original code tried to use Hindi TTS for Tamil text → doesn't work!

---

## ✅ The Solution (Choose One)

### Option 1: English + Voice Cloning ⭐ RECOMMENDED
**Cell 9 in notebook**

```bash
pip install TTS
export COQUI_TOS_AGREED=1
```

**Pros:** Perfect voice cloning, sounds like original speaker  
**Cons:** Output in English (not Tamil)  
**Output:** `sample_X_english_dubbed.wav`

---

### Option 2: Tamil + Generic Voice
**Cell 10 in notebook**

```bash
pip install gtts pydub
```

**Pros:** Proper Tamil pronunciation  
**Cons:** No voice cloning, generic voice  
**Output:** `sample_X_tamil_gtts.wav`

---

## 🎯 Which Should I Use?

| If You Need... | Use... |
|----------------|--------|
| Best audio quality | Cell 9 (English) |
| Voice cloning | Cell 9 (English) |
| Tamil language | Cell 10 (Tamil) |
| Both? | Run both cells! |

---

## 📋 Quick Steps

1. **Install dependencies:**
   ```bash
   bash install_tts.sh
   # Choose option 3 (both)
   ```

2. **Open notebook:**
   ```bash
   jupyter notebook starter.ipynb
   ```

3. **Run cells:**
   - Cells 1-7: Setup (loads all models)
   - **Cell 9**: English dubbing ← Run this!
   - **Cell 10**: Tamil output ← Or this!

4. **Listen to output:**
   - `test_audio/sample_1_english_dubbed.wav`
   - `test_audio/sample_1_tamil_gtts.wav`

---

## ❌ Don't Do This

- ❌ Don't run Cell 8 (old, broken)
- ❌ Don't use `language="hi"` for Tamil text
- ❌ Don't expect voice cloning with Google TTS

---

## 📚 Need More Help?

- **TTS_GUIDE.md** - Complete troubleshooting guide
- **README.md** - Full documentation
- **Cell 11** - Experimental Tamil TTS (not ready yet)

---

## 💡 Pro Tip

Generate BOTH versions:
1. Cell 9 → English with original voice ✨
2. Cell 10 → Tamil with clear pronunciation 🗣️
3. Use English for demos, Tamil for verification!

---

**That's it! You're ready to go! 🚀**

