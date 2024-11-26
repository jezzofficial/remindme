#!/usr/bin/env python3

import argparse
import subprocess
from datetime import datetime, timedelta
import time
import os

def send_notification(message):
    subprocess.run(['notify-send', message])

def parse_time(time_str, date_str=None):
    now = datetime.now()

    # Парсинг времени
    target_time = datetime.strptime(time_str, '%H:%M').time()

    # Если указана дата, используем ее, иначе используем текущую дату
    if date_str:
        target_date = datetime.strptime(date_str, '%d.%m').date()
        target_datetime = datetime.combine(target_date, target_time)
    else:
        target_datetime = datetime.combine(now.date(), target_time)

    # Если время уже прошло, переносим на следующий день
    if target_datetime < now:
        target_datetime += timedelta(days=1)

    return target_datetime

def schedule_reminder(message, target_datetime):
    delta_seconds = (target_datetime - datetime.now()).total_seconds()
    if delta_seconds > 0:
        print(f'Напоминание установлено на {target_datetime}')
        time.sleep(delta_seconds)
        send_notification(message)
    else:
        print("Ошибка: Указанное время в прошлом.")

def main():
    parser = argparse.ArgumentParser(description='Reminder program')
    parser.add_argument('message', type=str, help='The reminder message')
    parser.add_argument('at', type=str, help='Keyword "at"', choices=['at'])
    parser.add_argument('time', type=str, help='Time in HH:MM format')
    parser.add_argument('date', nargs='?', type=str, help='Optional date in DD.MM format')
    
    args = parser.parse_args()

    # Парсинг времени и даты
    target_datetime = parse_time(args.time, args.date)

    # Уходим в фоновый процесс
    if os.fork() == 0:
        schedule_reminder(args.message, target_datetime)

if __name__ == '__main__':
    main()