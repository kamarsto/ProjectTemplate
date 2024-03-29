#!/bin/sh
CURRENT_DIR=$(git rev-parse --show-prefix)
if [ -d ../ProjectTemplate ]
then
    echo "Error: cannot add to subtree from inside the ProjectTemplate folder. Please move addSubtreeToHooks.sh to the directory above and run it from there"
    read -p "Press Enter to continue" </dev/tty
    exit 1
fi

rm -rf ProjectTemplate

while [ ! -d .git ]
do
	cd ..
done

git subtree add --prefix "${CURRENT_DIR}ProjectTemplate" https://github.com/kamarsto/ProjectTemplate main --squash

if [ ! -f UpdateProjectTemplate.sh ]
then
# 	mkdir .githooks
	touch UpdateProjectTemplate.sh
	echo "#!/bin/bash" >> UpdateProjectTemplate.sh
	echo "echo \"Updating LaTeX template\"" >> UpdateProjectTemplate.sh
	git add UpdateProjectTemplate.sh
	git commit --no-verify -m "[SYS] Added the missing UpdateProjectTemplate.sh script"
fi
echo "git subtree pull --prefix \"${CURRENT_DIR}ProjectTemplate\" \"https://github.com/kamarsto/ProjectTemplate\" main --squash" >> UpdateProjectTemplate.sh
git add UpdateProjectTemplate.sh
git commit --no-verify -m "[SYS] Added ProjectTemplate to ${CURRENT_DIR}ProjectTemplate"
