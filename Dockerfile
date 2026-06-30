FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .

RUN groupadd --system appgroup \
    && useradd --system --gid appgroup --create-home --home-dir /home/appuser appuser

COPY --chown=appuser:appgroup . .

RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

USER appuser

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
