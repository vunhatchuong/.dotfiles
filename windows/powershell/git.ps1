# Prevent conflict with built-in aliases
Remove-Alias gc -Force -ErrorAction SilentlyContinue
Remove-Alias gcb -Force -ErrorAction SilentlyContinue
Remove-Alias gcm -Force -ErrorAction SilentlyContinue
Remove-Alias gcs -Force -ErrorAction SilentlyContinue
Remove-Alias gl -Force -ErrorAction SilentlyContinue
Remove-Alias gm -Force -ErrorAction SilentlyContinue
Remove-Alias gp -Force -ErrorAction SilentlyContinue
Remove-Alias gpv -Force -ErrorAction SilentlyContinue

function pretty-git-log
{
    $HASH = "%C(always,yellow)%h%C(always,reset)"
    $RELATIVE_TIME = "%C(always,green)%ar%C(always,reset)"
    $AUTHOR = "%C(always,bold blue)%an%C(always,reset)"
    $REFS = "%C(always,red)%d%C(always,reset)"
    $SUBJECT = "%s"

    $FORMAT = "$HASH $RELATIVE_TIME{$AUTHOR{$REFS $SUBJECT"

    git log --graph --pretty="tformat:$FORMAT" $args |
    ForEach-Object { $_ -replace '{', " " } |
    Out-Host
}

bashAlias gr "git remote @args"
bashAlias gra "git remote add @args"
bashAlias grset "git remote set-url @args"
bashAlias grv "git remote -v @args"

bashAlias gst "git status @args"
bashAlias ga "git add @args"
bashAlias gaa "git add --all"

bashAlias gcam "git commit -a -m @args"
bashAlias gcmsg "git commit -m @args"

bashAlias gl "git pull @args"
bashAlias gm "git merge @args"

bashAlias gb "git branch @args"
bashAlias gba "git branch -a"

bashAlias gc "git clone @args"
bashAlias gco "git checkout @args"
bashAlias gcb "git checkout -b @args"

bashAlias gd "git diff @args"
bashAlias gdc "git diff --cached @args"

bashAlias gp "git push @args"
bashAlias gpd "git push --dry-run @args"

bashAlias glo "git log --oneline --decorate"
bashAlias glog "git log --oneline --decorate --graph"
bashAlias "glp" "pretty-git-log"
