@echo off

:: Create a temporary directory for images
mkdir temp_images 2>nul

:: Convert Mermaid diagrams to images using Mermaid CLI
mermaid-cli architecture_document.md -o temp_images

:: Convert the entire document to PDF
pandoc architecture_document.md -o architecture_document.pdf --pdf-engine=xelatex -V geometry:a4paper -V geometry:margin=1in

echo Conversion complete! PDF saved as architecture_document.pdf
echo You can find the images in the temp_images directory

pause
