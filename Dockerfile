# Базовый образ: Легкий Python 3.10 для Django-приложения
FROM python:3.10-slim

# Параметры среды: Отключаем bytecode и буферизацию для продакшена
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Рабочая директория в контейнере
WORKDIR /app

# Копируем файл зависимостей и устанавливаем (для кэширования слоёв Docker)
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь код проекта (включая WebBooks и catalog)
COPY . /app/

# Открываем порт для доступа к приложению (Django на 8000)
EXPOSE 8000

# Команда запуска: Переходим в папку WebBooks, применяем миграции, запускаем сервер
CMD ["sh", "-c", "cd WebBooks && python manage.py migrate && python manage.py runserver 0.0.0.0:8000"]