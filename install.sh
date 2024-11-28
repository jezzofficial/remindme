#!/bin/bash
clear
# Цвета
CYAN='\033[1;36m'
NC='\033[0m'

# Функция для отображения логотипа
function show_logo {
    echo -e "${CYAN}"
    echo "██████╗ ███████╗███╗   ███╗██╗███╗   ██╗██████╗     ███╗   ███╗███████╗"
    echo "██╔══██╗██╔════╝████╗ ████║██║████╗  ██║██╔══██╗    ████╗ ████║██╔════╝"
    echo "██████╔╝█████╗  ██╔████╔██║██║██╔██╗ ██║██║  ██║    ██╔████╔██║█████╗  "
    echo "██╔══██╗██╔══╝  ██║╚██╔╝██║██║██║╚██╗██║██║  ██║    ██║╚██╔╝██║██╔══╝  "
    echo "██║  ██║███████╗██║ ╚═╝ ██║██║██║ ╚████║██████╔╝    ██║ ╚═╝ ██║███████╗"
    echo "╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝╚═════╝     ╚═╝     ╚═╝╚══════╝"
    echo -e "${NC}"
    echo -e "${CYAN}Remind Me - Установка by jezzi${NC} >3"
}
# Функция для установки алиаса
function install_alias {
    CONFIG_FILE=$1
    ALIAS_COMMAND=$2

    echo "Вы изменяли местоположение файла $CONFIG_FILE? (Yy/Nn)"
    read -r answer
    case $answer in
        [Yy]* )
            echo "Укажите полный путь до конфигурационного файла:"
            read -r CONFIG_FILE
            ;;
        [Nn]* )
            echo "Будет использоваться стандартный путь: $CONFIG_FILE"
            ;;
        * )
            echo "Ответ не распознан. Используется стандартный путь: $CONFIG_FILE"
            ;;
    esac

    echo "Добавляем алиас в $CONFIG_FILE..."
    if ! grep -qF "$ALIAS_COMMAND" "$CONFIG_FILE"; then
        echo "$ALIAS_COMMAND" >> "$CONFIG_FILE"
        echo "Алиас добавлен в $CONFIG_FILE."
    else
        echo "Алиас уже существует в $CONFIG_FILE."
    fi
}

# Основной сценарий
show_logo
echo "Выберите вашу консоль:"
PS3="Введите номер: "
options=("Zsh" "Bash" "Выход")
select opt in "${options[@]}"; do
    case $opt in
        "Zsh")
            CONFIG_FILE="$HOME/.zshrc"
            ALIAS_COMMAND='alias remind="python ~/remindme/remind.py"'
            install_alias "$CONFIG_FILE" "$ALIAS_COMMAND"
            break
            ;;
        "Bash")
            CONFIG_FILE="$HOME/.bashrc"
            ALIAS_COMMAND='alias remind="python ~/remindme/remind.py"'
            install_alias "$CONFIG_FILE" "$ALIAS_COMMAND"
            break
            ;;
        "Выход")
            echo "Выход из установщика."
            exit 0
            ;;
        *)
            echo "Неверный выбор. Попробуйте снова."
            ;;
    esac
done

# Создание каталога и перенос файла
INSTALL_DIR="$HOME/remindme"
echo "Создаем каталог $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"
if mv remind.py "$INSTALL_DIR/" 2>/dev/null; then
    echo "Файл remind.py успешно перемещен."
else
    echo "Ошибка: файл remind.py не найден. Убедитесь, что он находится рядом с этим скриптом."
    exit 1
fi

# Финальное сообщение
echo "Установка завершена!"
echo "Перезагрузите терминал или выполните 'source $CONFIG_FILE', чтобы использовать алиас 'remind'."
echo "Нажмите Enter, чтобы выйти."
read -r
exit 0
