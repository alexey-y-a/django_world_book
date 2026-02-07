# Django World Book — веб-приложение для каталога книг

Веб-приложение на Django для просмотра и управления каталогом книг.

### Основные возможности

- Просмотр списка книг
- Статические файлы: стили (CSS), изображения (логотип и обложки)
- Локальная база данных SQLite (`db.sqlite3`)
- Админ-панель Django (по адресу `/admin/`)

---

## Архитектура
- Монолитное Django-приложение: основная точка входа — `manage.py` (в корне и в `WebBooks/WebBooks`).
- Приложение `catalog` содержит основные модели и шаблоны.
- Статические файлы хранятся в `static/`, собранные файлы для деплоя — в `staticfiles/`.
- По умолчанию используется SQLite (`WebBooks/db.sqlite3`) для локальной разработки.

## Функциональность
- Веб-интерфейс 
- Админ Django: доступ после создания суперпользователя по `/admin/`.
- Отправка почты — через консольный backend в `settings.py` (для разработки).

## Технологии
- Python 3.10 
- Django 4.1.7
- SQLite (локальная разработка)
- HTML + CSS (простые шаблоны)
- Docker / docker-compose

---

## Быстрый старт (локально)
1. Перейдите в корень репозитория

2. Важно: если `requirements.txt` выглядит «битым» (странные символы), он, вероятно, в UTF-16 — перекодируйте в UTF-8:
```bash
# Если файл выглядит битым (странные символы) — он в UTF-16
file requirements.txt

# Перекодировка (выберите один способ)
# Способ 1 — iconv (если установлен)
iconv -f UTF-16 -t UTF-8 requirements.txt > req.tmp && mv req.tmp requirements.txt

# Способ 2 — через Python (универсальный)
python3 -c "open('requirements.txt','w',encoding='utf-8').write(open('requirements.txt','r',encoding='utf-16',errors='replace').read())"
```

3. Создать виртуальное окружение и активировать его:
```bash
python3 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
```

4. Установить зависимости:
```bash
pip install -r requirements.txt
```

5. Применить миграции:
```bash
cd WebBooks
python3 manage.py migrate
```

6. Создать суперпользователя (для доступа как админ):
```bash
python3 manage.py createsuperuser
```

7. Запустить сервер (нужно перейти в `WebBooks`):
```bash
python3 manage.py runserver
```
Откройте браузер и перейдите по адресу:
http://127.0.0.1:8000
или
http://localhost:8000

---

## Примеры запросов
- Открыть главную страницу в браузере: `http://127.0.0.1:8000/`
- Админ: `http://127.0.0.1:8000/admin/`
- Если нужно проверить статику, откройте `http://127.0.0.1:8000/static/css/styles.css` (пример).

---

## Docker
Сборка образа (убедитесь, что `requirements.txt` в UTF-8):
```bash
docker build -t django_world_book .
```
Запуск контейнера (порт 8000):
```bash
docker run --rm -p 8000:8000 django_world_book
```
Примечание: текущий `Dockerfile` выполняет `migrate` и запускает `runserver` — это удобно для разработки, 
но для production рекомендуется запускать `gunicorn WebBooks.wsgi:application` и делать `collectstatic` отдельно.

---

## Структура проекта (основные файлы и папки)
```
django_world_book/
├── README.md
├── Dockerfile
├── Procfile
├── requirements.txt
├── manage.py               # точка входа (корень)
├── WebBooks/               # django проект
│   ├── manage.py
│   ├── WebBooks/           # package с settings.py, wsgi.py
│   │   ├── settings.py
│   │   └── wsgi.py
│   ├── catalog/            # django app с моделями и шаблонами
│   ├── static/             # статика для разработки
│   └── staticfiles/        # collectstatic сюда складывает файлы
└── db.sqlite3              # локальная БД 
```

---

## Частые проблемы и их решения
- `requirements.txt` выглядит «битым» — файл в UTF-16: перекодируйте в UTF-8 (см. выше).
---

## Что можно добавить
- `run.sh` — исполняемый скрипт для быстрого старта (создаёт venv, ставит deps, применяет миграции и запускает сервер). 
- `Makefile` — короткие цели: `install`, `migrate`, `run`, `docker-build`.

