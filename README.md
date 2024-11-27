<b>Remind.py</b> 
-------------------------------
<i>Манипуляции производятся на Arch Linux</i>

<i>Самодельная программа написанная на Python для отправки уведомлений на базе демона Dunst.</i>

| <b>Работает методом ввода <i>py</i> файла и аргументов в одну строку.</b> <i>(Парсит значения)</i>

~~~python
parser = argparse.ArgumentParser(description='Reminder program')
parser.add_argument('message', type=str, help='The reminder message')
parser.add_argument('at', type=str, help='Keyword "at"', choices=['at'])
parser.add_argument('time', type=str, help='Time in HH:MM format')
parser.add_argument('date', nargs='?', type=str, help='Optional date in DD.MM format')
~~~


## _Пример использования:_

#### Указать событие и время в текущий день 
_(Если указать время которое уже прошло, напоминание перенесется на следующий день)_.
~~~bash
remind.py "Позвонить в бухгалтерию." at 12:22
~~~

#### Указать событие и время на выбранную дату в формате DD:MM 
_(Если указать время которое уже прошло, программа сообщит о том, что выбранное время в прошлом)_.
~~~bash
remind.py "Позвонить в бухгалтерию." at 12:22 12.12
~~~

-------------------------------
## Лучший вариант: настроить alias для консоли:
#### Настройка для zsh:
~~~bash
vim ~/.zshrc
~~~
_Вписываете эту строчку в конец файла_
~~~bash
alias remind='/home/<user>/ПУТЬ ХРАНЕНИЯ ФАЙЛА/remind.py'
~~~

#### Настройка для bashrc:
~~~bash
vim ~/.bashrc
~~~
_Вписываете эту строчку в конец файла_
~~~bash
alias remind='/home/<user>/ПУТЬ ХРАНЕНИЯ ФАЙЛА/remind.py'
~~~

><b>Все так подробно расписано исключительно для новичков</b>

### После чего команда будет выглядеть так:
~~~bash
remind "Позвонить в бухгалтерию." at 12:22
remind "Позвонить в бухгалтерию." at 12:22 12.12
~~~

|_Более того, будет доступна из любой части системы_

### Хорошего использования!

