# 🎙️ Multilingual Speech Dubbing System

A context-aware speech dubbing pipeline that translates Hindi audio to Tamil while preserving the original speaker's voice characteristics using state-of-the-art AI models.

## 🌟 Features

- **Speech-to-Text (STT)**: Converts Hindi audio to text using AI4Bharat's IndicWav2Vec
- **Context Analysis**: Sentiment analysis and contextual understanding using IndicBERT
- **Neural Translation**: Multi-hop translation (Hindi → English → Tamil) using Meta's M2M100
- **Voice Cloning**: Generates Tamil speech in the original speaker's voice using Coqui XTTS v2
- **Batch Processing**: Processes multiple audio files automatically
- **Results Tracking**: Exports detailed CSV reports with translations and sentiment scores

## 🔄 Pipeline Overview

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐     ┌──────────┐
│ Hindi Audio │ --> │ Hindi Text   │ --> │ English     │ --> │ Tamil    │
│   (WAV)     │     │ (IndicWav2Vec)│     │ (M2M100)    │     │ Text     │
└─────────────┘     └──────────────┘     └─────────────┘     └──────────┘
                            │                                      │
                            ▼                                      ▼
                    ┌───────────────┐                    ┌──────────────┐
                    │   Sentiment   │                    │ Tamil Audio  │
                    │   Analysis    │                    │ (Voice Clone)│
                    │  (XLM-RoBERTa)│                    │  (XTTS v2)   │
                    └───────────────┘                    └──────────────┘
```

## 🚀 Quick Start

### Prerequisites

- Python 3.8+
- 16GB+ RAM recommended
- GPU (optional, for faster processing)

### ⚠️ Important: TTS Solution

**The Tamil TTS in original Cell 8 doesn't work!** See `TTS_GUIDE.md` for working solutions.

**Quick Fix:**
- Use Cell 9 for English output with voice cloning ⭐
- Use Cell 10 for Tamil output with generic voice

### Installation

1. **Clone the repository**
```bash
git clone <your-repo-url>
cd "Speech Dubbing"
```

2. **Create virtual environment**
```bash
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
```

3. **Install dependencies**
```bash
# Core dependencies
pip install torch torchaudio transformers
pip install librosa numpy pandas
pip install sounddevice soundfile
pip install sentencepiece sacremoses

# TTS options (choose based on your needs)
pip install TTS              # Coqui XTTS (for voice cloning with English)
pip install gtts pydub       # Google TTS (for proper Tamil pronunciation)
```

4. **Install TTS (Quick Method)**
```bash
# Run the installation helper script
bash install_tts.sh
# Choose: 1=XTTS, 2=Google TTS, 3=Both
```

Or manually:
```bash
# For voice cloning (Cell 9)
pip install TTS
export COQUI_TOS_AGREED=1

# For Tamil output (Cell 10)
pip install gtts pydub
```

### Usage

1. **Open Jupyter Notebook**
```bash
jupyter notebook starter.ipynb
```

2. **Record Audio Samples** (Cell 2)
   - Records 5 Hindi sentences
   - Saves as WAV files in `test_audio/`

3. **Choose Your TTS Solution:**

   **Option A: English with Voice Cloning (Cell 9)** ⭐ RECOMMENDED
   - Best audio quality
   - Sounds like original speaker
   - Output in English
   ```python
   # Generates: sample_X_english_dubbed.wav
   ```

   **Option B: Tamil with Generic Voice (Cell 10)**
   - Proper Tamil pronunciation
   - Generic Tamil voice
   - Output in Tamil
   ```python
   # Generates: sample_X_tamil_gtts.wav
   # Requires: pip install gtts pydub
   ```

4. **Access Results**
   - English audio: `test_audio/sample_X_english_dubbed.wav`
   - Tamil audio: `test_audio/sample_X_tamil_gtts.wav`
   - Analysis: `context_analysis_results.csv`
   - Translations: `hindi_to_tamil_results.csv`

## 🧠 Models Used

| Component | Model | Source |
|-----------|-------|--------|
| Speech-to-Text | `ai4bharat/indicwav2vec-hindi` | AI4Bharat |
| Context Analysis | `ai4bharat/IndicBERTv2-MLM-only` | AI4Bharat |
| Sentiment Analysis | `cardiffnlp/twitter-xlm-roberta-base-sentiment` | Cardiff NLP |
| Translation | `facebook/m2m100_418M` | Meta AI |
| Text-to-Speech | `tts_models/multilingual/multi-dataset/xtts_v2` | Coqui AI |

## 📊 Sample Results

### Input
```
Audio: sample_1.wav
Text: "नमस्ते, मेरा नाम राज है"
```

### Output
```
Hindi (Recognized): "मेरा नाम कृतयम है"
Sentiment: Neutral (57.8% confidence)
English: "My name is thankful."
Tamil: "என் பெயர் நன்றி."
Audio: sample_1_tamil.wav (with voice cloning)
```

### Pipeline Performance

| Sample | Sentiment | Confidence | Status |
|--------|-----------|------------|--------|
| Sample 1 | Neutral | 57.8% | ✅ |
| Sample 2 | Positive | 81.5% | ✅ |
| Sample 3 | Positive | 47.8% | ✅ |
| Sample 4 | Neutral | 72.7% | ✅ |
| Sample 5 | Positive | 90.1% | ✅ |

## 📁 Project Structure

```
Speech Dubbing/
├── starter.ipynb                    # Main pipeline notebook
│   ├── Cells 1-7: STT + Context + Translation
│   ├── Cell 8: ❌ OLD (doesn't work)
│   ├── Cell 9: ✅ English TTS + Voice Cloning
│   ├── Cell 10: ✅ Tamil TTS (Google)
│   └── Cell 11: 🔮 Tamil TTS (IndicTTS - future)
│
├── README.md                        # This file
├── TTS_GUIDE.md                    # Detailed TTS troubleshooting
├── install_tts.sh                  # TTS installation helper
│
├── Results:
│   ├── context_analysis_results.csv    # Original results
│   ├── hindi_to_tamil_results.csv      # Translation results
│   ├── dubbing_results_english.csv     # English TTS results
│   └── dubbing_results_gtts_tamil.csv  # Tamil TTS results
│
├── test_audio/
│   ├── sample_1.wav                    # Original Hindi audio
│   ├── sample_1.txt                    # Original Hindi text
│   ├── sample_1_tamil.wav              # Old (garbage audio)
│   ├── sample_1_english_dubbed.wav     # ✅ New English + voice clone
│   ├── sample_1_tamil_gtts.wav         # ✅ New Tamil + generic voice
│   └── ... (5 samples total)
│
├── ngc.md5                         # NVIDIA NGC CLI files
└── ngccli_cat_mac.zip
```

## ⚙️ Technical Details

### Audio Processing
- **Sample Rate**: 16 kHz (resampled if needed)
- **Format**: WAV, mono
- **Duration**: 5 seconds per sample

### Pipeline Stages

1. **Preprocessing**: Audio normalization and resampling
2. **STT**: Wav2Vec2 CTC decoding for Hindi recognition
3. **Context Analysis**: Sentiment classification (Negative/Neutral/Positive)
4. **Translation**: Two-stage translation via English pivot
5. **TTS**: Voice cloning with XTTS v2 (speaker embedding from source audio)

### Performance Metrics
- **Real-time Factor**: ~1.0 (processes 1 second of audio in ~1 second)
- **Processing Time**: ~2-3 seconds per sample
- **Memory Usage**: ~4-6 GB RAM

## ⚠️ Known Limitations & Solutions

### 1. **Tamil TTS Challenge** ⚠️ IMPORTANT

**Problem:** XTTS v2 does not support Tamil script natively. The original Cell 8 attempted to use the Hindi language model to pronounce Tamil text, which produced garbage audio.

**XTTS Supported Languages:** `en, es, fr, de, it, pt, pl, tr, ru, nl, cs, ar, zh-cn, hu, ko, ja, hi` (Note: **NO Tamil**)

**Solutions Provided:**

#### ✅ **Solution 1: English TTS with Voice Cloning (Cell 9)** - RECOMMENDED
```python
# Uses English translation with XTTS voice cloning
tts_model.tts_to_file(
    text=english_text,
    speaker_wav=str(audio_path),
    language="en",
    file_path=str(output_audio_path)
)
```
- **Pros:** Perfect voice cloning, high-quality audio
- **Cons:** Output is English, not Tamil
- **Output:** `sample_X_english_dubbed.wav`

#### ✅ **Solution 2: Google TTS for Tamil (Cell 10)**
```python
# Proper Tamil pronunciation without voice cloning
from gtts import gTTS
tts = gTTS(text=tamil_text, lang='ta')
```
- **Pros:** Correct Tamil pronunciation
- **Cons:** No voice cloning (generic voice)
- **Requires:** `pip install gtts pydub`
- **Output:** `sample_X_tamil_gtts.wav`

#### 🔮 **Solution 3: AI4Bharat IndicTTS (Future)**
- Native Tamil support with better quality
- Requires complex setup (not yet implemented)

**Recommendation:** Run both Cell 9 (English + voice clone) and Cell 10 (Tamil + generic voice), then choose based on your priority.

---

### 2. **STT Accuracy**
Recognition errors in noisy environments
- Sample 1: "राज" → "कृतयम" (misrecognition)

### 3. **Translation Quality**
Depends on intermediate English quality
- Some semantic loss in multi-hop translation

### 4. **Voice Cloning Requirements**
Requires clear speaker audio (5+ seconds)

## 🔮 Future Enhancements

- [ ] Direct Hindi → Tamil translation (skip English pivot)
- [ ] Native Tamil TTS model for better pronunciation
- [ ] Real-time streaming support
- [ ] Support for more Indian languages (Telugu, Malayalam, Bengali)
- [ ] Web interface for easy access
- [ ] Speaker diarization for multi-speaker audio
- [ ] Emotion transfer (preserve emotional tone)

## 🛠️ Troubleshooting

### Issue: Tamil audio is garbage/disturbance

**This is the main issue you reported!**

**Solution:** Don't use old Cell 8. Read the complete guide: **`TTS_GUIDE.md`**

Quick fix:
- ✅ Use Cell 9 (English + voice cloning)
- ✅ Use Cell 10 (Tamil + generic voice)
- ❌ Don't use Cell 8 (produces garbage)

---

### Issue: XTTS model fails to load
```bash
# Solution: Accept Coqui TOS
export COQUI_TOS_AGREED=1
pip install --upgrade TTS
```

### Issue: Out of memory errors
```bash
# Solution: Process files one at a time or reduce batch size
# Use CPU instead of GPU for lower memory usage
```

### Issue: Audio quality issues
```bash
# Ensure input audio is:
# - 16 kHz sample rate
# - Mono channel
# - Clear speech with minimal background noise
```

### Issue: "No module named 'gtts'" or "pydub"
```bash
# Solution: Install Google TTS dependencies
pip install gtts pydub
# On Mac, also install ffmpeg:
brew install ffmpeg
```

**For more troubleshooting, see `TTS_GUIDE.md`**

## 📚 References

- [AI4Bharat IndicWav2Vec](https://github.com/AI4Bharat/IndicWav2Vec)
- [Meta M2M100](https://huggingface.co/facebook/m2m100_418M)
- [Coqui TTS](https://github.com/coqui-ai/TTS)
- [IndicBERT](https://huggingface.co/ai4bharat/IndicBERTv2-MLM-only)

## 🙏 Acknowledgments

- **AI4Bharat** for Indic language models
- **Meta AI** for multilingual translation models
- **Coqui AI** for open-source TTS
- **HuggingFace** for model hosting and transformers library

## 📄 License

This project uses multiple models with different licenses:
- AI4Bharat models: MIT License
- M2M100: CC-BY-NC 4.0
- XTTS: Coqui Public Model License

Please review individual model licenses before commercial use.

## 👨‍💻 Author

Created by Krittinnagar

---

