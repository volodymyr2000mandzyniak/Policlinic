# Поліклініка - Система електронних записів

![Ruby Version](https://img.shields.io/badge/Ruby-3.0+-red)
![Rails Version](https://img.shields.io/badge/Rails-7.0-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-13+-blueviolet)


## 1. Посилання на додаток
https://softgeneration-b9a1bfa3cdb2.herokuapp.com

## 1. Посилання на адмін панель
https://softgeneration-b9a1bfa3cdb2.herokuapp.com/admin
### Email = admin@clinic.dev 
### PASSWORD = supersecret

## 1. Загальний опис

Додаток надає можливість:

### Для пацієнтів
✅ Реєстрація та вхід у свій профайл за номером телефону
✅ Записуватися до лікарів  
✅ Переглядати рекомендації  
✅ Переглядати своїми записами  

### Для лікарів
✅ Керувати записами пацієнтів  
✅ Залишати рекомендації  
✅ Переглядати свій розклад 
✅ Після реєстрації ваш статус буде на розгляді адміністратора і тільки після підтвердження ви зможете отримувати запис а та відображатись на загальні стоірці  

### Для адміністраторів
✅ Керувати лікарями та категоріями  
✅ Керувати користувачами  
✅ Моніторинг системи  
✅ Створення категорій
✅ Підтвердження або скасування нових лікарів

## Технологічний стек

**Backend**:
- Ruby on Rails v7
- PostgreSQL

**Безпека**:
- Devise (phone + password)
- CanCanCan (авторизація)

**Адміністрування**:
- ActiveAdmin

**Інфраструктура**:
- AWS S3 (зберігання фото)
- Деплой на AWS/Heroku

## Встановлення
```bash

1. Клонуйте репозиторій: git clone https://github.com/yourusername/polyclinic.git
2. Перейдіть у католог: cd polyclinic
3. виконайте командуbundle install
4. Створіть базу даних rails db:create
5. Виконайте міграції: rails db:migrate.
6. Виконайте Seed: rails db:seed.
7. Запустіть сервер: rails server.
