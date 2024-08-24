# GLaDOsh

GLaDOsh is a run command code to invoke GLaDOS when you make fail a command.

This is purely a toy to make a PoC, nothing else. Don't take it as a real tool
to use in production.

It uses an IA to generate an answer to your error and sends it to
[piper-tts](https://github.com/rhasspy/piper) to create an audio file. It is
then played by vlc in background.

This repository uses a French voice sample, but you can replace the model files
with any other voice and change the Modelfile to change the behavior of the IA.

## Installation

Before installing, you may want to check the **run_command.sh** file.

1. Clone this repo with submodule recursion
2. Install the packages in packages.txt with your package manager
3. install piper-tts with the requirements.txt file using pip
4. Execute **install.sh** giving the path to your run command file (bashrc, zshrc, ...)

## Usage

In your shell, to activate GLaDOsh:

```text
gladosh on
```

From now on, everytime you will fail a command, GLaDOS will correct you.

To deactivate GLaDOsh:

```text
gladosh off
```

## Information

I use the [piper-voice-glados-fr](https://github.com/TazzerMAN/piper-voice-glados-fr)
from [TazzerMAN](https://github.com/TazzerMAN) to generate the voice. You can
use another model if you want to use another file.

The model is defined in the models/Modefile file. You can change the behavior
within this file.

I use [Ollama](https://ollama.com) as large language models with the model
[Gemma2:2b](https://ollama.com/library/gemma2:2b)

There's still bugs for now. The most problematic one being stderr not printable
for regular execution without fail.

Also, it may be a bit slow to generate a voice. It depends on your computer.
