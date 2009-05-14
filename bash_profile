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
git co $to && git pull
echo "-- 2. Switching back to '$from'..."
git co $from
echo "-- 3. Rebasing '$to' to include '$from'..."
git rebase $to
echo "-- 4. Switching back to '$to'..."
git co $to
echo "-- 5. Merging in '$from'..."
git merge $from
echo "-- 6. Displaying branch status..."
git wtf
echo "== Would you like to push '$from' to '$to'? y for YES"
read INPUT
if [ "$INPUT" == "y" ]; then
        echo "-- 7. Pushing changes on '$from' to '$to' (please wait)..."
        sleep 1
        git push
else
        echo "== Please complete publish with 'git push' in '$to' whenever you're ready"
fi
echo "== All actions completed..."
}
