@echo off
echo Creating PDF from Mermaid diagrams...

:: Create a temporary directory for images
mkdir temp_images 2>nul

:: Convert Mermaid diagrams to images using Mermaid CLI
mermaid-cli final_architecture.md -o temp_images

:: Convert the entire document to PDF
pandoc final_architecture.md -o architecture_diagram.pdf --pdf-engine=xelatex -V geometry:a4paper -V geometry:margin=1in

echo PDF created successfully as architecture_diagram.pdf
echo You can find the images in the temp_images directory

pause
