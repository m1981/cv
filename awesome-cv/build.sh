#!/bin/bash
# Build CV PDF using XeLaTeX
# Requires: BasicTeX or MacTeX installed via Homebrew

cd "$(dirname "$0")"

# Check if xelatex is available
if ! command -v xelatex &> /dev/null; then
    echo "ERROR: xelatex not found."
    echo ""
    echo "Install BasicTeX first:"
    echo "  brew install --cask basictex"
    echo ""
    echo "Then restart terminal and run:"
    echo "  eval \"\$(/usr/libexec/path_helper)\""
    echo "  sudo tlmgr install awesome-cv 2>/dev/null || true"
    echo "  bash build.sh"
    exit 1
fi

echo "Building CV..."

# Run xelatex twice for proper references
xelatex -interaction=nonstopmode cv-michal.tex
xelatex -interaction=nonstopmode cv-michal.tex

# Clean up aux files
rm -f *.aux *.log *.out *.fdb_latexmk *.fls *.synctex.gz

if [ -f "cv-michal.pdf" ]; then
    echo ""
    echo "SUCCESS: CV built at $(pwd)/cv-michal.pdf"
    open cv-michal.pdf
else
    echo ""
    echo "FAILED: PDF was not generated. Check the log output above."
fi
