#!/bin/sh

if [ $# -eq 1 ]
then
    run_command_file="$1"
else
    echo "Usage: $0 RUN_COMMAND_FILE" 2>&1
    exit 1
fi

gladosh_dir=$HOME/.local/gladosh
models_dir=$gladosh_dir/models
model_tarball=piper-voice-glados-fr/models/fr_FR-glados-medium.tar.gz

mkdir -p $models_dir

tar xf $model_tarball -C $models_dir
cp models/Modelfile $models_dir

curl -fsSL https://ollama.com/install.sh | sh

ollama pull gemma2:2b

echo "GLaDOsh: INPUT '/bye' INTO THE NEXT PROMPT!"
ollama run gemma2:2b

ollama create gladosh -f $models_dir/Modelfile

cat run_command.sh >> $1

echo "Execute 'source $1' to update your shell"
