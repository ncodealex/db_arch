# База данных для системы складского учета в прокате шоу оборудования
Доработка базы данных для системы складского учета в прокате шоу оборудования.

![Текущая схема](ShowRent%5B2%5D.png)

[Визуализация схемы](https://www.drawdb.app/editor?shareId=05d8c8e5ce26636f27eaac91fcaec7e5)


# Отчет об использовании индексов в базе данных

---

## Таблицы, индексы и порядок полей

### Таблица: `products`
- **`products_index_for_search`**: Ускоряет поиск по полям в следующем порядке:
    1. `article_number`
    2. `name`
    3. `delete_at`
    4. `type`
- **`products_index_for_filtration`**: Оптимизирует фильтрацию по полям в следующем порядке:
    1. `category_id`
    2. `delete_at`
    3. `group_id`
    4. `type`
    5. `is_active`

---

### Таблица: `product_physical_properties`
- **`product_physical_properties_index_weight`**: Для вычисления агрегатов, связанных с полем:
    1. `weight`
- **`product_physical_properties_index_volume`**: Для вычисления агрегатов, связанных с полем:
    1. `volume`
- **`product_physical_properties_index_power`**: Для вычисления агрегатов, связанных с полем:
    1. `power`
- **`product_physical_properties_index_for_calculate_in_order`**: Используется для вычислений, ( будет использовано в будущем) связанных с полями в следующем порядке:
    1. `weight`
    2. `volume`
    3. `power`

---

### Таблица: `product_categories`
- **`product_categories_index_for_tree_build`**: Ускоряет построение иерархии категорий по полям в следующем порядке:
    1. `parent_id`
    2. `delete_at`
- **`product_categories_index_for_search`**: Оптимизирует поиск по полям в следующем порядке:
    1. `name`
    2. `delete_at`
---

### Таблица: `product_units`
- **`product_units_index_for_search`**: Ускоряет поиск по полям в следующем порядке:
    1. `name`
    2. `delete_at`
- **`product_units_index_for_list`**: Оптимизирует фильтрацию по полю:
    1. `delete_at`

---

### Таблица: `product_groups`
- **`product_groups_index_for_search`**: Ускоряет поиск по полям в следующем порядке:
  + `name`
  + `delete_at`
- **`product_groups_index_for_list`**: Оптимизирует фильтрацию по полю:
  + `delete_at`

---

### Таблица: `product_brands`
- **`product_brands_index_for_search`**: Ускоряет поиск по полям в следующем порядке:
    1. `name`
    2. `delete_at`
- **`product_brands_index_for_list`**: Оптимизирует запрос для выборки всех брендов с учетом удаленных / неудаленных по полю:
    1. `delete_at`

---

### Таблица: `product_kit_items`
- **`product_kit_items_for_aggregates`**: Ускоряет вычисления агрегатов, связанных с полем:
    1. `amount`

---

### Таблица: `product_serials`
- **`product_serials_index_for_filtration`**: Оптимизирует фильтрацию по полям в следующем порядке:
    1. `working_status`
    2. `delete_at`

---

### Таблица: `warehouse_storage_locations`
- **`warehouse_storage_locations_index_for_search`**: Ускоряет поиск по полям в следующем порядке:
    1. `name`
    2. `type`
    3. `delete_at`
- **`warehouse_storage_locations_index_for_filtration`**: Оптимизирует фильтрацию по полям в следующем порядке:
    1. `type`
    2. `delete_at`

---

### Таблица: `warehouse_report_stocks_in_locations`
- **`warehouse_report_stocks_in_locations_index_for_filtration`**: Ускоряет фильтрацию по полям в следующем порядке:
    1. `date_registration`
    2. `amount`

---

### Таблица: `warehouse_stock_movements`
- **`warehouse_stock_movements_index_for_aggregate`**: Оптимизирует агрегатные вычисления по полям в следующем порядке:
    1. `date_registration`
    2. `amount`
- **`warehouse_stock_movements_index_for_filtration_by_actor`**: Для фильтрации по актору (например, документы 
  инвентаризации или еще какие) по полям в 
  следующем порядке:
    1. `actor_id`
    2. `actor_type`

---

### Таблица: `warehouse_inventories`
- **`warehouse_inventories_index_for_filtration`**: Ускоряет фильтрацию по полям в следующем порядке:
    1. `document_date`
    2. `held_at`
    3. `finish_at`
    4. `status`
    5. `held`
    6. `location_id`

---
