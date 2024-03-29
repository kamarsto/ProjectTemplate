#!/bin/sh
CURRENT_DIR=$(git rev-parse --show-prefix)
if [ -d ../latextemplate ]
then
    echo "Error: cannot add to subtree from inside the latextemplate folder. Please move addSubtreeToHooks.sh to the directory above and run it from there"
    read -p "Press Enter to continue" </dev/tty
    exit 1
fi

rm -rf latextemplate

while [ ! -d .git ]
do
	cd ..
done

git subtree add --prefix "${CURRENT_DIR}latextemplate" https://gitlab.com/sekcja-rakietowa-ska/latextemplate master --squash

if [ ! -f UpdateLatexTemplate.sh ]
then
# 	mkdir .githooks
	touch UpdateLatexTemplate.sh
	echo "#!/bin/bash" >> UpdateLatexTemplate.sh
	echo "echo \"Updating LaTeX template\"" >> UpdateLatexTemplate.sh
	git add UpdateLatexTemplate.sh
	git commit --no-verify -m "[SYS] Added the missing UpdateLatexTemplate.sh script"
fi
echo "git subtree pull --prefix \"${CURRENT_DIR}latextemplate\" \"https://gitlab.com/sekcja-rakietowa-ska/latextemplate\" master --squash" >> UpdateLatexTemplate.sh
git add UpdateLatexTemplate.sh
git commit --no-verify -m "[SYS] Added latextemplate to ${CURRENT_DIR}latextemplate"
