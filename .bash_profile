function GIT_BRANCH() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		echo "⌥ ${BRANCH}"
	else
		echo ""
	fi
}

PS1="\[\e[1m\]\W\[\e[0m\]\`GIT_BRANCH\` "

export CLICOLOR=1
