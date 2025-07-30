# Поліклініка - Система електронних записів

![Ruby Version](https://img.shields.io/badge/Ruby-3.0+-red)
![Rails Version](https://img.shields.io/badge/Rails-7.0-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-13+-blueviolet)

```bash
# 1. Клонування
git clone https://github.com/yourusername/polyclinic.git
cd polyclinic

## 1. Посилання на додаток
https://softgeneration-b9a1bfa3cdb2.herokuapp.com


## 1. Посилання на додат
https://softgeneration-b9a1bfa3cdb2.herokuapp.com/admin
Email = admin@clinic.dev 
PASSWORD = supersecret

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

1. Встановіть залежності:
```bash
bundle install
yarn install
