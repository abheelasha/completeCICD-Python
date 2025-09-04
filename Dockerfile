FROM python:3
WORKDIR /app
RUN pip install Django==5.2.6
COPY . .
RUN python manage.py migrate
EXPOSE 8000
CMD ["python","manage.py","runserver","0.0.0.0:8000"]

