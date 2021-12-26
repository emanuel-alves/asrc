# 

# Instalação

Cloando arquivo:

    git clone https://github.com/emanuel-alves/asrc.git $HOME/.asrc

Incluindo no arquivo de configuração do seu shell

    source $HOME/asrc/main.sh

# Modo de usar


    asrc [OPTIONS]                  
    asrc [SOURCE_1] [SOURCE_2] [...] 
    
    Options:
        -a, --add                               Adiciona um source
            Example: asrc -a [NAME] [SOURCE]

        -d, --delete                            Deleta um source
            Example: asrc -d [NAME] [SOURCE]

        -l, --list                              Lista os sources