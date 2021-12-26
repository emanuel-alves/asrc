function asrc() {
    function_help() {
        echo "Usage: "$0" [OPTIONS] or | "$0"[SOURCE_1] [SOURCE_2] [...]\n" 
        echo "\t-a, --add\t\tAdiciona um source" 
        echo "\t\tExample: "$0" -a [NAME] [SOURCE]\n"
        echo "\t-d, --delete\t\tDeleta um source"
        echo "\t\tExample: "$0" -d [NAME] [SOURCE]\n"
        echo "\t-l, --list\t\tLista os sources"
    }
    function_list() {
        while IFS="," read -r name local; do
            echo "$name\t->\t$local"
        done <$DATA_FILE
    }
    function_add() {
        while IFS="," read -r name local; do
            if [ $name = $1 ]; then
                echo "ERROR: "$1" já existe"
                exit 1
            fi
        done <$DATA_FILE

        echo $1","$2 >>$DATA_FILE
    }
    function_delete() {
        cp $DATA_FILE $DATA_FILE".bkp"
        rm $DATA_FILE

        while IFS="," read -r name local; do
            if [ $name != $1 ]; then
                echo "$name\t->\t$local" >>$DATA_FILE
            fi
        done <$DATA_FILE".bkp"
    }
    function_source() {
        STATUS=0
        for arg in "$@"; do
            STATUS=0
            while IFS="," read -r name local; do
                if [ $arg = $name ]; then
                    source $local
                    STATUS=1
                    break
                fi
            done <$DATA_FILE
            if [ $STATUS = 0 ]; then
                echo "ERROR: "$1" não existe"                
            fi
        done
    }
    DIR_SRC="$HOME/.asrc"
    DATA_FILE="$DIR_SRC/source.csv"
    if [ ! -d "$DIR_SRC" ]; then
        mkdir -p "$DIR_SRC"
    fi
    if [ ! -f "$DATA_FILE" ]; then
        touch "$DATA_FILE"
    fi

    case $1 in
    "-h" | "--help")
        function_help
        ;;
    "-l" | "--list")
        function_list
        ;;
    "-a" | "--add")
        function_add $2 $3
        ;;
    "-d" | "--delete")
        function_delete $2
        ;;
    *)
        function_source $*
        ;;
    esac
}