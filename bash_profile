#---------------------------------------------------------------------------#
#--                   publish_to functions                                --#
#---------------------------------------------------------------------------#
function publish_to {
current_branch=$(git branch 2>/dev/null | grep -e '^*' | sed -E 's/^\* (.+)$/\1 /')

if [ "$current_branch" == "" ]; then
  echo "Error - You do not appear to be on a branch to publish from, please check with 'git branch'";return;
fi
if [ "$1" != "" ]; then
  publish $current_branch $1
else
  echo "Please enter branch you wish to publish to."
  echo " --> For example: publish_to <some_branch_name>"
fi
}
function publish {
from=$1
to=$2
if [ "$from" == "" ]; then
        echo "== Error - Please specify branch to publish from"; return;
elif [ "$to" == "" ]; then
        echo "== Error - Please specify branch to publish to"; return;
fi
echo "-- 1. Checking out '$to' to latest version..."
git checkout $to && git pull
echo "-- 2. Switching back to '$from'..."
git checkout $from
echo "-- 3. Rebasing '$to' to include '$from'..."
git rebase $to
echo "-- 4. Switching back to '$to'..."
git checkout $to
echo "-- 5. Merging in '$from'..."
git merge $from
echo "-- 6. Displaying branch status..."
git wtf
read -r -a remotes <<< "$(git remote)"
remote=${remotes[0]}
echo "== Would you like to push '$from' to '$to'? Please select option (or any key to skip):"
echo "1) Push '$to' - (git push $remote $to)"
echo "2) Push all - (git push)" 
echo "-) Skip"
read -n1 -s -r -t30 INPUT  
case "$INPUT" in
"1")
echo "-- 7. Pushing all changes on '$to' to remote '$remote' (please wait)..."
sleep 1
git push $remote $to;;
"2")
echo "-- 7. Pushing all changes on '$from' to '$to' (please wait)..."
sleep 1
git push;;
*)
echo "== Please complete publish with 'git push remote $to' / 'git push' while in '$to' whenever you're ready";;
esac  
echo "== All actions completed..."
}
#---------------------------------------------------------------------------#
#--                   end of publish_to functions                         --#
#---------------------------------------------------------------------------#