###########
# GLaDOsh #
###########

gladosh_dir="$HOME/.local/gladosh"
gladosh_log="$gladosh_dir/$$_log.txt"
gladosh_model=$gladosh_dir/models/fr_FR-glados-medium.onnx

gladosh_ia ()
{
    exit_status=$?
    prompt_to_ia="$(< $gladosh_log)"
    echo -n "$prompt_to_ia"

    if [ -z "$prompt_to_ia" ]
    then
        answer=""
    else
        answer=$(curl http://localhost:11434/api/generate -d "{ \"model\": \"gladosh\", \"prompt\": \"$prompt_to_ia\", \"stream\": false }" 2>/dev/null | jq -r '.response')
        answer=$(echo -n $answer | sed 's/\*//g' | sed 's/\// slash /g')

    fi

    echo "$answer : L'exit status est à $exit_status" | piper-tts --model $gladosh_model --output_file $gladosh_dir/error.wav >/dev/null 2>&1
    (cvlc --play-and-exit $gladosh_dir/error.wav >/dev/null 2>&1 &)
    rm $gladosh_log
    exec 2>$gladosh_log
    return $exit_status
}

gladosh()
{
    if [ $# -ne 1 ]
    then
        echo "Usage: gladosh on/off" >&2
        exit 1
    fi

    if [ "$1" = "on" ]
    then
        exec 2>$gladosh_log
        trap gladosh_ia ERR
        [ ! -d "$gladosh_dir" ] && mkdir -p $gladosh_dir/models
    elif [ "$1" = "off" ]
    then
        exec 2>/dev/pts/2
        trap - ERR
    else
        echo "Usage: gladosh on/off" >&2
        exit 1
    fi
}
