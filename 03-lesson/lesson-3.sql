--  0) Создание БД
CREATE DATABASE show_rent
--  1) Создание таблиц

CREATE TABLE "products" (
                            "id" UUID NOT NULL UNIQUE,
                            "type" CHAR(12) NOT NULL,
                            "article_number" VARCHAR(255) NOT NULL UNIQUE,
                            "name" VARCHAR(255) NOT NULL,
                            "name_print" VARCHAR(255),
                            "warehouse_accounting" VARCHAR(255) NOT NULL,
                            "critical_stock_level" DECIMAL(4),
                            "category_id" UUID NOT NULL,
                            "brand_id" UUID NOT NULL,
                            "unit_id" UUID NOT NULL,
                            "group_id" UUID NOT NULL,
                            "is_active" BOOLEAN NOT NULL,
                            "sort" INTEGER NOT NULL,
                            "created_at" TIMESTAMP NOT NULL,
                            "update_at" TIMESTAMP NOT NULL,
                            "delete_at" TIMESTAMP,
                            PRIMARY KEY("id")
);
CREATE INDEX "products_index_for_search"
    ON "products" ("article_number", "name", "delete_at", "type");

CREATE INDEX "products_index_for_filtration"
    ON "products" ("category_id", "delete_at", "group_id", "type", "is_active");

CREATE TABLE "product_physical_properties" (
                                               "id" INTEGER NOT NULL UNIQUE GENERATED BY DEFAULT AS IDENTITY,
                                               "product_id" UUID NOT NULL,
                                               "width" INTEGER,
                                               "height" INTEGER,
                                               "length" INTEGER,
                                               "volume" INTEGER,
                                               "weight" INTEGER,
                                               "power" INTEGER,
                                               "consumption" INTEGER,
                                               PRIMARY KEY("id")
);
CREATE INDEX "product_physical_properties_index_weight"
    ON "product_physical_properties" ("weight");

CREATE INDEX "product_physical_properties_index_volume"
    ON "product_physical_properties" ("volume");

CREATE INDEX "product_physical_properties_index_power"
    ON "product_physical_properties" ("power");

CREATE INDEX "product_physical_properties_index_for_calculate_in_order"
    ON "product_physical_properties" ("weight", "volume", "power");

CREATE TABLE "product_categories" (
                                      "id" UUID NOT NULL UNIQUE,
                                      "parent_id" UUID,
                                      "name" VARCHAR(255) NOT NULL,
                                      "depth" INTEGER NOT NULL,
                                      "sort" INTEGER NOT NULL,
                                      "is_system" BOOLEAN NOT NULL,
                                      "is_default" BOOLEAN NOT NULL,
                                      "created_at" TIMESTAMP NOT NULL,
                                      "update_at" TIMESTAMP NOT NULL,
                                      "delete_at" TIMESTAMP,
                                      PRIMARY KEY("id")
);
CREATE INDEX "product_categories_index_for_tree_build"
    ON "product_categories" ("parent_id", "delete_at");

CREATE INDEX "product_categories_index_for_search"
    ON "product_categories" ("name", "delete_at");

CREATE TABLE "product_units" (
                                 "id" UUID NOT NULL UNIQUE,
                                 "name" VARCHAR(255) NOT NULL,
                                 "sort" INTEGER NOT NULL DEFAULT 0,
                                 "is_system" BOOLEAN NOT NULL,
                                 "is_default" BOOLEAN NOT NULL,
                                 "created_at" TIMESTAMP NOT NULL,
                                 "update_at" TIMESTAMP NOT NULL,
                                 "delete_at" TIMESTAMP,
                                 PRIMARY KEY("id")
);
CREATE INDEX "product_units_index_for_search"
    ON "product_units" ("name", "delete_at");

CREATE INDEX "product_units_index_for_list"
    ON "product_units" ("delete_at");

CREATE TABLE "product_groups" (
                                  "id" UUID NOT NULL UNIQUE,
                                  "name" VARCHAR(255) NOT NULL,
    -- hex color code
                                  "color" CHAR(7) NOT NULL,
                                  "sort" INTEGER NOT NULL,
                                  "is_system" BOOLEAN NOT NULL,
                                  "is_default" BOOLEAN NOT NULL,
                                  "update_at" TIMESTAMP NOT NULL,
                                  "created_at" TIMESTAMP NOT NULL,
                                  "delete_at" TIMESTAMP,
                                  PRIMARY KEY("id")
);COMMENT ON COLUMN product_groups.color IS 'hex color code';

CREATE INDEX "product_groups_index_for_search"
    ON "product_groups" ("name", "delete_at");

CREATE INDEX "product_groups_index_for_list"
    ON "product_groups" ("delete_at");

CREATE TABLE "product_brands" (
                                  "id" UUID NOT NULL UNIQUE,
                                  "name" VARCHAR(255) NOT NULL,
                                  "sort" INTEGER NOT NULL DEFAULT 0,
                                  "is_system" BOOLEAN NOT NULL,
                                  "is_default" BOOLEAN NOT NULL,
                                  "update_at" TIMESTAMP NOT NULL,
                                  "delete_at" TIMESTAMP,
                                  "created_at" TIMESTAMP NOT NULL,
                                  PRIMARY KEY("id")
);
CREATE INDEX "product_brands_index_for_search"
    ON "product_brands" ("name", "delete_at");

CREATE INDEX "product_brands_index_for_list"
    ON "product_brands" ("delete_at");

CREATE TABLE "product_kit_properties" (
                                          "id" INTEGER NOT NULL UNIQUE GENERATED BY DEFAULT AS IDENTITY,
                                          "product_id" UUID NOT NULL,
                                          "content_control" VARCHAR(255) NOT NULL,
                                          "price_control" VARCHAR(255) NOT NULL,
                                          PRIMARY KEY("id")
);

CREATE TABLE "product_kit_items" (
                                     "id" INTEGER NOT NULL UNIQUE GENERATED BY DEFAULT AS IDENTITY,
                                     "kit_id" INTEGER NOT NULL,
                                     "product_id" UUID NOT NULL,
                                     "amount" DECIMAL(4) NOT NULL DEFAULT 1,
                                     "sort" INTEGER NOT NULL DEFAULT 0,
                                     PRIMARY KEY("id")
);
CREATE INDEX "product_kit_items_for_aggregates"
    ON "product_kit_items" ("amount");

CREATE TABLE "product_accessories" (
                                       "id" INTEGER NOT NULL UNIQUE GENERATED BY DEFAULT AS IDENTITY,
                                       "product_id" UUID NOT NULL,
                                       "product_as_accessory_id" UUID NOT NULL,
                                       "auto_add" BOOLEAN NOT NULL,
                                       "miss_if_added" BOOLEAN NOT NULL,
                                       "add_as_new_string" BOOLEAN NOT NULL,
                                       "free" BOOLEAN NOT NULL,
                                       "amount" DECIMAL(4) NOT NULL DEFAULT 1,
                                       "sort" INTEGER NOT NULL DEFAULT 0,
                                       PRIMARY KEY("id")
);

CREATE TABLE "product_analogs" (
                                   "id" INTEGER NOT NULL UNIQUE GENERATED BY DEFAULT AS IDENTITY,
                                   "product_id" UUID NOT NULL,
                                   "product_as_analog_id" UUID NOT NULL,
                                   "sort" INTEGER NOT NULL DEFAULT 0,
                                   PRIMARY KEY("id")
);

CREATE TABLE "product_consumable_properies" (
                                                "id" INTEGER NOT NULL UNIQUE GENERATED BY DEFAULT AS IDENTITY,
                                                "product_id" UUID NOT NULL,
                                                "accounting" VARCHAR(255) NOT NULL,
                                                "wrire_off_amount" DECIMAL(4) NOT NULL DEFAULT 0,
                                                PRIMARY KEY("id")
);

CREATE TABLE "product_serials" (
                                   "sku" VARCHAR(12) NOT NULL UNIQUE,
                                   "product_id" UUID NOT NULL,
                                   "working_status" VARCHAR(255) NOT NULL,
                                   "manufacturer_number" VARCHAR(255),
                                   "comment" VARCHAR(255),
                                   "sort" INTEGER NOT NULL DEFAULT 0,
                                   "created_at" TIMESTAMP NOT NULL,
                                   "update_at" TIMESTAMP NOT NULL,
                                   "delete_at" TIMESTAMP,
                                   PRIMARY KEY("sku")
);
CREATE INDEX "product_serials_index_for_filtration"
    ON "product_serials" ("working_status", "delete_at");

CREATE TABLE "warehouse_storage_locations" (
                                               "id" UUID NOT NULL UNIQUE,
                                               "name" VARCHAR(255) NOT NULL,
    -- internal - внутренний склад
    -- external- внешний ( для ремонта в другой мастерской и пр.)
                                               "type" CHAR(1) NOT NULL,
    -- hex color code
                                               "color" CHAR(7) NOT NULL,
                                               "is_system" BOOLEAN NOT NULL,
                                               "is_default" BOOLEAN NOT NULL,
                                               "sort" INTEGER NOT NULL,
                                               "created_at" TIMESTAMP NOT NULL,
                                               "update_at" TIMESTAMP NOT NULL,
                                               "delete_at" TIMESTAMP,
                                               PRIMARY KEY("id")
);COMMENT ON COLUMN warehouse_storage_locations.type IS 'internal - внутренний склад
external- внешний ( для ремонта в другой мастерской и пр.)';
COMMENT ON COLUMN warehouse_storage_locations.color IS 'hex color code';

CREATE INDEX "warehouse_storage_locations_index_for_search"
    ON "warehouse_storage_locations" ("name", "type", "delete_at");

CREATE INDEX "warehouse_storage_locations_index_for_filtration"
    ON "warehouse_storage_locations" ("type", "delete_at");

CREATE TABLE "warehouse_current_stock_balances" (
                                                    "product_id" UUID NOT NULL UNIQUE,
                                                    "amount" DECIMAL(4) NOT NULL DEFAULT 0,
                                                    "update_at" TIME NOT NULL,
                                                    PRIMARY KEY("product_id")
);

CREATE TABLE "warehouse_report_stocks_in_locations" (
                                                        "id" INTEGER NOT NULL UNIQUE GENERATED BY DEFAULT AS IDENTITY,
                                                        "location_id" UUID NOT NULL,
                                                        "product_id" UUID NOT NULL,
                                                        "serial_sku" VARCHAR(12) NOT NULL,
                                                        "amount" DECIMAL(4) NOT NULL DEFAULT 0,
                                                        "date_registration" TIMESTAMP NOT NULL,
                                                        PRIMARY KEY("id")
);
CREATE INDEX "warehouse_report_stocks_in_locations_index_for_filtration"
    ON "warehouse_report_stocks_in_locations" ("date_registration", "amount");

CREATE TABLE "warehouse_stock_movements" (
                                             "id" INTEGER NOT NULL UNIQUE GENERATED BY DEFAULT AS IDENTITY,
                                             "location_id" UUID NOT NULL,
                                             "product_id" UUID NOT NULL,
                                             "serial_sku" VARCHAR(12) NOT NULL,
                                             "amount" DECIMAL(4) NOT NULL DEFAULT 0,
                                             "date_registration" TIMESTAMP NOT NULL,
                                             "actor_id" UUID NOT NULL,
                                             "actor_type" VARCHAR(255) NOT NULL,
                                             PRIMARY KEY("id")
);
CREATE INDEX "warehouse_stock_movements_index_for_aggregate"
    ON "warehouse_stock_movements" ("date_registration", "amount");

CREATE INDEX "warehouse_stock_movements_index_for_filtration_by_actor"
    ON "warehouse_stock_movements" ("actor_id", "actor_type");

CREATE TABLE "warehouse_inventories" (
                                         "id" UUID NOT NULL UNIQUE,
    -- Человекопонятный номер.
    -- Используется в поиске по номеру документа.
                                         "number" CHAR(12) NOT NULL,
                                         "status" VARCHAR(255),
                                         "document_date" TIMESTAMP NOT NULL,
                                         "held" BOOLEAN NOT NULL,
                                         "held_at" TIMESTAMP,
                                         "location_id" UUID,
                                         "held_by_user_id" UUID,
                                         "comment" VARCHAR(255),
                                         "created_at" TIMESTAMP NOT NULL,
                                         "update_at" TIMESTAMP NOT NULL,
                                         "finish_at" TIMESTAMP,
                                         PRIMARY KEY("id")
);COMMENT ON COLUMN warehouse_inventories.number IS 'Человекопонятный номер.
Используется в поиске по номеру документа.';

CREATE INDEX "warehouse_inventories_index_for_filtration"
    ON "warehouse_inventories" ("document_date", "held_at", "finish_at", "status", "held", "location_id");

CREATE TABLE "warehouse_inventory_rows" (
                                            "id" INTEGER NOT NULL UNIQUE GENERATED BY DEFAULT AS IDENTITY,
                                            "inventory_id" UUID NOT NULL,
                                            "product_id" UUID NOT NULL,
                                            "product_warehouse_accounting" VARCHAR(255) NOT NULL,
                                            "status" VARCHAR(255) NOT NULL,
                                            "counted" DECIMAL NOT NULL,
                                            "current_stock" DECIMAL NOT NULL,
                                            "deviation" DECIMAL NOT NULL,
    -- Поле нужно для дальнейшей блокировки. Изменить текущую строку сможет только юзер который её добавил.
                                            "add_by_user_id" UUID NOT NULL,
                                            "sort" INTEGER,
                                            PRIMARY KEY("id")
);COMMENT ON COLUMN warehouse_inventory_rows.add_by_user_id IS 'Поле нужно для дальнейшей блокировки. Изменить текущую строку сможет только юзер который её добавил.';


CREATE TABLE "warehouse_inventory_row_serials" (
                                                   "id" INTEGER NOT NULL UNIQUE GENERATED BY DEFAULT AS IDENTITY,
                                                   "inventory_row" INTEGER NOT NULL,
                                                   "serial_sku" VARCHAR(12) NOT NULL,
                                                   "status" BOOLEAN,
                                                   PRIMARY KEY("id")
);

ALTER TABLE "product_physical_properties"
    ADD FOREIGN KEY("product_id") REFERENCES "products"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "product_categories"
    ADD FOREIGN KEY("parent_id") REFERENCES "product_categories"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "product_kit_properties"
    ADD FOREIGN KEY("product_id") REFERENCES "products"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "product_kit_items"
    ADD FOREIGN KEY("kit_id") REFERENCES "product_kit_properties"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "product_kit_items"
    ADD FOREIGN KEY("product_id") REFERENCES "products"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "product_accessories"
    ADD FOREIGN KEY("product_id") REFERENCES "products"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "product_accessories"
    ADD FOREIGN KEY("product_as_accessory_id") REFERENCES "products"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "product_analogs"
    ADD FOREIGN KEY("product_id") REFERENCES "products"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "product_analogs"
    ADD FOREIGN KEY("product_as_analog_id") REFERENCES "products"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "product_consumable_properies"
    ADD FOREIGN KEY("product_id") REFERENCES "products"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "products"
    ADD FOREIGN KEY("category_id") REFERENCES "product_categories"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "products"
    ADD FOREIGN KEY("brand_id") REFERENCES "product_brands"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "products"
    ADD FOREIGN KEY("unit_id") REFERENCES "product_units"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "products"
    ADD FOREIGN KEY("group_id") REFERENCES "product_groups"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "product_serials"
    ADD FOREIGN KEY("product_id") REFERENCES "products"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "products"
    ADD FOREIGN KEY("id") REFERENCES "warehouse_current_stock_balances"("product_id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "warehouse_report_stocks_in_locations"
    ADD FOREIGN KEY("location_id") REFERENCES "warehouse_storage_locations"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "warehouse_report_stocks_in_locations"
    ADD FOREIGN KEY("product_id") REFERENCES "products"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "warehouse_report_stocks_in_locations"
    ADD FOREIGN KEY("serial_sku") REFERENCES "product_serials"("sku")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "warehouse_stock_movements"
    ADD FOREIGN KEY("location_id") REFERENCES "warehouse_storage_locations"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "warehouse_stock_movements"
    ADD FOREIGN KEY("product_id") REFERENCES "products"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "warehouse_stock_movements"
    ADD FOREIGN KEY("serial_sku") REFERENCES "product_serials"("sku")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "warehouse_inventory_rows"
    ADD FOREIGN KEY("inventory_id") REFERENCES "warehouse_inventories"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "warehouse_inventory_rows"
    ADD FOREIGN KEY("product_id") REFERENCES "products"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "warehouse_inventory_row_serials"
    ADD FOREIGN KEY("inventory_row") REFERENCES "warehouse_inventory_rows"("id")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE "warehouse_inventory_row_serials"
    ADD FOREIGN KEY("serial_sku") REFERENCES "product_serials"("sku")
        ON UPDATE NO ACTION ON DELETE NO ACTION;

--  2) Создание Схем

CREATE SCHEMA IF NOT EXISTS products;
CREATE SCHEMA IF NOT EXISTS warehouse;

--  2) Удаление Схем

DROP SCHEMA products;
DROP SCHEMA warehouse;

--  3) Перемещаем в схемы таблички

ALTER TABLE "products" SET SCHEMA products;
ALTER TABLE "product_physical_properties" SET SCHEMA products;
ALTER TABLE "product_categories" SET SCHEMA products;
ALTER TABLE "product_units" SET SCHEMA products;
ALTER TABLE "product_groups" SET SCHEMA products;
ALTER TABLE "product_brands" SET SCHEMA products;
ALTER TABLE "product_kit_properties" SET SCHEMA products;
ALTER TABLE "product_kit_items" SET SCHEMA products;
ALTER TABLE "product_accessories" SET SCHEMA products;
ALTER TABLE "product_analogs" SET SCHEMA products;
ALTER TABLE "product_consumable_properies" SET SCHEMA products;
ALTER TABLE "product_serials" SET SCHEMA products;

ALTER TABLE "warehouse_storage_locations" SET SCHEMA warehouse;
ALTER TABLE "warehouse_current_stock_balances" SET SCHEMA warehouse;
ALTER TABLE "warehouse_report_stocks_in_locations" SET SCHEMA warehouse;
ALTER TABLE "warehouse_stock_movements" SET SCHEMA warehouse;
ALTER TABLE "warehouse_inventories" SET SCHEMA warehouse;
ALTER TABLE "warehouse_inventory_rows" SET SCHEMA warehouse;
ALTER TABLE "warehouse_inventory_row_serials" SET SCHEMA warehouse;

-- 4) Создание табличных пространств
CREATE TABLESPACE product_tablespace LOCATION '/var/lib/postgresql/data/product';
CREATE TABLESPACE warehouse_tablespace LOCATION '/var/lib/postgresql/data/warehouse';

-- 5) Создание ролей
CREATE ROLE product_role LOGIN PASSWORD 'product_password';
CREATE ROLE warehouse_role LOGIN PASSWORD 'warehouse_password';

-- 6) Назначение владельцев для таблиц
ALTER TABLE product.products OWNER TO product_role;
ALTER TABLE product.product_physical_properties OWNER TO product_role;
ALTER TABLE product.product_categories OWNER TO product_role;
ALTER TABLE product.product_units OWNER TO product_role;
ALTER TABLE product.product_groups OWNER TO product_role;
ALTER TABLE product.product_brands OWNER TO product_role;
ALTER TABLE product.product_kit_properties OWNER TO product_role;
ALTER TABLE product.product_kit_items OWNER TO product_role;
ALTER TABLE product.product_accessories OWNER TO product_role;
ALTER TABLE product.product_analogs OWNER TO product_role;
ALTER TABLE product.product_consumable_properies OWNER TO product_role;
ALTER TABLE product.product_serials OWNER TO product_role;

ALTER TABLE warehouse.warehouse_storage_locations OWNER TO warehouse_role;
ALTER TABLE warehouse.warehouse_current_stock_balances OWNER TO warehouse_role;
ALTER TABLE warehouse.warehouse_report_stocks_in_locations OWNER TO warehouse_role;
ALTER TABLE warehouse.warehouse_stock_movements OWNER TO warehouse_role;
ALTER TABLE warehouse.warehouse_inventories OWNER TO warehouse_role;
ALTER TABLE warehouse.warehouse_inventory_rows OWNER TO warehouse_role;
ALTER TABLE warehouse.warehouse_inventory_row_serials OWNER TO warehouse_role;

-- 7) Назначение табличных пространств для схем
ALTER SCHEMA product SET TABLESPACE product_tablespace;
ALTER SCHEMA warehouse SET TABLESPACE warehouse_tablespace;

-- 8) Назначение прав доступа
GRANT ALL PRIVILEGES ON SCHEMA product TO product_role;
GRANT ALL PRIVILEGES ON SCHEMA warehouse TO warehouse_role;
