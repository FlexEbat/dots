#!/bin/bash

# Путь к папке с репозиторием
REPO_DIR=~/mygit
# chmod +x git_auto_push.sh

# Переходим в папку с репозиторием
cd $REPO_DIR || exit

# Проверяем, есть ли изменения
git add .

# Делаем коммит с текущей датой и временем
git commit -m "Автоматический коммит $(date '+%Y-%m-%d %H:%M:%S')"

# Пытаемся отправить изменения в репозиторий
git pull origin main --rebase
if [ $? -ne 0 ]; then
  echo "Ошибка при синхронизации с удалённым репозиторием. Проверьте конфликты!"
  exit 1
fi

# Отправляем изменения на GitHub
git push -u origin main

# Если push прошел успешно
if [ $? -eq 0 ]; then
  echo "Изменения успешно отправлены на GitHub!"
else
  echo "Не удалось отправить изменения на GitHub."
  exit 1
fi

