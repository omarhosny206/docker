# Stage 1: Build the application
FROM python:3.10-alpine as builder

WORKDIR /app

COPY ./requirements.txt .

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Stage 2: Create a runtime container
FROM python:3.10-alpine as runtime

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /app /app

CMD ["python", "app.py"]
