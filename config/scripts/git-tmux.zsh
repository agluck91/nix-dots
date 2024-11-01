if [ -d .git ]; then
	git fetch
	branch=$(git rev-parse --abbrev-ref HEAD)
	ahead=$(git rev-list --count origin/$branch..$branch)
	behind=$(git rev-list --count $branch..origin/$branch)
	echo "$branch $ahead $behind"
else
	echo "N/A"
fi
