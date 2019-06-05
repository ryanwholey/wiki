#!/usr/bin/env sh
set -e

rm -rf build/*.md
mkdir -p build

find projects -type d -maxdepth 1 -mindepth 1 | while read -r projectDir
do
    project=$(basename "$projectDir")
    raml2html --theme raml2html-markdown-theme --pretty -t templates/md/template.nunjucks -i "projects/$project/spec.raml" -o "./build/$project.md"
done

cd build || exit
git add .
git commit -m "Documentation update: $(date +%Y%m%dT%H%M%S)"
git push origin master
