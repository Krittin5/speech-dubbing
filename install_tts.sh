#!/bin/bash

echo "=================================================="
echo "Speech Dubbing TTS Installation Script"
echo "=================================================="
echo ""
echo "Choose your TTS solution:"
echo ""
echo "1. XTTS (Voice Cloning - English output)"
echo "   - Best audio quality"
echo "   - Sounds like original speaker"
echo "   - Output: English"
echo ""
echo "2. Google TTS (Proper Tamil pronunciation)"
echo "   - Correct Tamil pronunciation"
echo "   - Generic Tamil voice"
echo "   - Output: Tamil"
echo ""
echo "3. Both (Recommended)"
echo ""
read -p "Enter choice (1/2/3): " choice

echo ""
echo "Installing..."
echo ""

case $choice in
    1)
        echo "Installing Coqui TTS..."
        pip install TTS
        export COQUI_TOS_AGREED=1
        echo "✅ XTTS installed! Run Cell 9 in the notebook."
        ;;
    2)
        echo "Installing Google TTS..."
        pip install gtts pydub
        echo "✅ Google TTS installed! Run Cell 10 in the notebook."
        ;;
    3)
        echo "Installing both TTS solutions..."
        pip install TTS gtts pydub
        export COQUI_TOS_AGREED=1
        echo "✅ Both TTS solutions installed!"
        echo "   - Cell 9: English with voice cloning"
        echo "   - Cell 10: Tamil with generic voice"
        ;;
    *)
        echo "❌ Invalid choice. Please run again and select 1, 2, or 3."
        exit 1
        ;;
esac

echo ""
echo "=================================================="
echo "Installation complete!"
echo "=================================================="
echo ""
echo "Next steps:"
echo "1. Open starter.ipynb"
echo "2. Run cells 1-7 to load models and process audio"
echo "3. Run Cell 9 (English) or Cell 10 (Tamil) for TTS"
echo ""

