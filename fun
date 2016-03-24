if [ ! -d $1 ]; then
    echo "$1 is not a directory"; exit 1
fi

while read -rd $'\0' x; do
    if [ -d "$x" ]; then
        mkdir -p ${x/${1%%/}/${1%%/}.size}
    elif [ -f "$x" ]; then
        size=$(du -b "$x" | awk '{print $1}')
        x="${x//.txt/}"
        echo $size > "${x/${1%%/}/${1%%/}.size}.size"
    fi
done < <(find $1 -mindepth 1 ! -uid 0 -print0)
