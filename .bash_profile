source ~/.profile
source ~/.bash/git-completion.bash

alias changes="svn st -q --ignore-externals"
function update_externals_to() {
	svn ps svn:externals "`svn pg svn:externals . | sed -E s/-r\([0-9]\+\)/-r$1/`" .
	echo "New Value:"
	echo "`svn pg svn:externals .`"
}
