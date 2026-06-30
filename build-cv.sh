#!/bin/bash
cd "$(dirname "$0")"

if ! command -v xelatex &> /dev/null; then
    echo "xelatex not found. Run these commands first:"
    echo ""
    echo "  brew install --cask basictex"
    echo "  (close and reopen terminal)"
    echo "  eval \"\$(/usr/libexec/path_helper)\""
    echo ""
    echo "Then run this script again."
    exit 1
fi

echo "Building CV..."
xelatex -interaction=nonstopmode cv-michal-single.tex > /dev/null 2>&1
xelatex -interaction=nonstopmode cv-michal-single.tex > /dev/null 2>&1

rm -f *.aux *.log *.out *.fdb_latexmk *.fls *.synctex.gz

if [ -f "cv-michal-single.pdf" ]; then
    echo "Done: $(pwd)/cv-michal-single.pdf"
    open cv-michal-single.pdf
else
    echo "Build failed. Running with full output:"
    xelatex -interaction=nonstopmode cv-michal-single.tex
fi
