export ZDOTDIR=~/.zshrc.d
export ZLE_RPROMPT_INDENT=0

# get the current platform
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
    export PLATFORM='osx'
elif [[ $unamestr == *CYGWIN* ]]; then
    export PLATFORM='cygwin'
elif [[ $unamestr == 'Linux' ]]; then
    export PLATFORM='linux'
else
    export PLATFORM='other'
fi
