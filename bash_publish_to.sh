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
git checkout $to
git fetch origin
git rebase -p origin/$to
echo "-- 2. Switching back to '$from'..."
git checkout $from
echo "-- 3. Rebasing '$to' to include '$from' (with -p to preserve )..."
git rebase -p $to
echo "-- 4. Switching back to '$to'..."
git checkout $to
echo "-- 5. Merging in '$from'..."
git merge $from
echo "-- 6. Displaying branch status..."
git wtf
publish_push_options
echo "== All actions completed..."
}
function publish_push_options {
remotes=""
normal_options=1
read -a remotes <<< $(git remote)
remote_count=${#remotes[@]}
remote="${remotes[0]}"
printf "\n\n\n\n== Would you like to push? Please select option (or any key to skip):\n"
echo "1) Push all - (git push)"
if [ $remote_count -ge 1 ]; then
for ((i=0; i<$remote_count; i++))
do
echo "$((i+($normal_options+1)))) Push '$to' - (git push ${remotes[$i]} $to)"
done
fi
echo "-) Skip"
read -n1 -s -r -t30 INPUT
case "$INPUT" in
"1")
echo "== Pushing all changes on '$to' (please wait)..."
sleep 1
git push;;
*)
if [ "$INPUT" \< "$(($normal_options+$remote_count+1))" ]; then
remote="${remotes[($INPUT-($normal_options+1))]}";
echo "== $INPUT Pushing all changes on '$to' to remote '$remote' (please wait)...";
git push $remote $to;
else
echo "== Please complete publish with 'git push $remote $to' / 'git push' while in '$to' whenever you're ready" ;
fi;;
esac
}
#---------------------------------------------------------------------------#
#--                   end of publish_to functions                         --#
#---------------------------------------------------------------------------#