# --- Base image ---
FROM python:3.12-slim

# Python sozlamalari
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Tizim darajasidagi kutubxonalar (sqlite3, build tools va h.k.)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libsqlite3-dev \
    && rm -rf /var/lib/apt/lists/*

# Avval faqat requirements.txt ni nusxalab, cache dan foydalanamiz
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Qolgan loyiha fayllarini nusxalash
COPY . .

# Statik fayllarni yig'ish (agar STATIC_ROOT sozlangan bo'lsa)
RUN python manage.py collectstatic --noinput || true

EXPOSE 8000

# Ishga tushirish (production uchun gunicorn)
CMD ["gunicorn", "django_jinja.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]