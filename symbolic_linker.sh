targets=`ls -A ~/dotfiles | grep -P '^(?!^\.git$)' | egrep '^\.'`

for file in $targets
do
        ln -s ~/dotfiles/$file ~/$file
done
