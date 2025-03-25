CREATE TABLE "migrations" (
  "id" int(11) PRIMARY KEY NOT NULL,
  "migration" varchar(191) NOT NULL,
  "time_executed" datetime DEFAULT null,
  "created_at" datetime DEFAULT null
);

CREATE TABLE "products" (
  "created_at" datetime NOT NULL DEFAULT (current_timestamp()),
  "updated_at" datetime NOT NULL,
  "deleted_at" datetime DEFAULT null,
  "id" varchar(36) PRIMARY KEY NOT NULL,
  "art" varchar(255) DEFAULT null,
  "type" varchar(255) NOT NULL,
  "name" varchar(255) NOT NULL DEFAULT '',
  "name_print" varchar(255) DEFAULT null,
  "description" text DEFAULT null,
  "description_print" text DEFAULT null,
  "sort" int(11) NOT NULL DEFAULT 0,
  "is_active" tinyint(1) NOT NULL DEFAULT 0,
  "version" int(11) NOT NULL DEFAULT 1,
  "price" int(11) NOT NULL DEFAULT 0,
  "sub_rental_costs" int(11) NOT NULL DEFAULT 0,
  "warehouse_accounting" varchar(255) NOT NULL DEFAULT 'not_use',
  "critical_stock_level" int(11) NOT NULL,
  "stock_amount" int(11) NOT NULL,
  "kit_content_control" varchar(255) NOT NULL DEFAULT 'not_use',
  "kit_price_control" varchar(255) NOT NULL DEFAULT 'not_use',
  "consumables_accounting" varchar(255) NOT NULL DEFAULT 'not_use',
  "consumables_write_off_amount" int(11) NOT NULL,
  "category_id" varchar(36) DEFAULT null,
  "unit_id" varchar(36) DEFAULT null,
  "brand_id" varchar(36) DEFAULT null,
  "group_id" varchar(36) DEFAULT null,
  "width" int(11) DEFAULT null,
  "height" int(11) DEFAULT null,
  "length" int(11) DEFAULT null,
  "volume" int(11) DEFAULT null,
  "weight" int(11) DEFAULT null,
  "power" int(11) DEFAULT null,
  "consumption" int(11) DEFAULT null
);

CREATE TABLE "product_accessories" (
  "id" bigint(20) PRIMARY KEY NOT NULL,
  "parent_id" varchar(36) NOT NULL,
  "accessory_id" varchar(36) NOT NULL,
  "accessory_name" varchar(255) NOT NULL,
  "auto_add" tinyint(1) NOT NULL DEFAULT 0,
  "miss_if_added" tinyint(1) NOT NULL DEFAULT 0,
  "add_as_new_string" tinyint(1) NOT NULL DEFAULT 0,
  "free" tinyint(1) NOT NULL DEFAULT 0,
  "count" int(11) NOT NULL DEFAULT 0,
  "sort" int(11) NOT NULL DEFAULT 0
);

CREATE TABLE "product_analogs" (
  "id" bigint(20) PRIMARY KEY NOT NULL,
  "parent_id" varchar(36) NOT NULL,
  "analog_id" varchar(36) NOT NULL,
  "analog_name" varchar(255) NOT NULL,
  "sort" int(11) NOT NULL DEFAULT 0
);

CREATE TABLE "product_box_items" (
  "id" bigint(20) PRIMARY KEY NOT NULL,
  "parent_id" varchar(36) NOT NULL,
  "box_item_id" varchar(36) NOT NULL,
  "box_item_name" varchar(255) NOT NULL,
  "count" int(11) NOT NULL DEFAULT 0,
  "sort" int(11) NOT NULL DEFAULT 0
);

CREATE TABLE "product_brands" (
  "id" varchar(36) PRIMARY KEY NOT NULL,
  "name" varchar(255) NOT NULL DEFAULT '',
  "comment" varchar(255) DEFAULT null,
  "is_system" tinyint(1) NOT NULL DEFAULT 0,
  "sort" int(11) NOT NULL DEFAULT 0,
  "created_at" datetime NOT NULL,
  "updated_at" datetime NOT NULL,
  "deleted_at" datetime DEFAULT null,
  "version" int(11) NOT NULL DEFAULT 1,
  "is_default" tinyint(1) NOT NULL DEFAULT 0
);

CREATE TABLE "product_categories" (
  "id" varchar(36) PRIMARY KEY NOT NULL,
  "name" varchar(255) NOT NULL,
  "is_system" tinyint(1) NOT NULL DEFAULT 0,
  "is_default" tinyint(1) NOT NULL DEFAULT 0,
  "comment" text DEFAULT null,
  "sort" int(11) NOT NULL DEFAULT 0,
  "depth" int(11) NOT NULL DEFAULT 0,
  "version" int(11) NOT NULL DEFAULT 1,
  "created_at" datetime NOT NULL,
  "updated_at" datetime NOT NULL,
  "deleted_at" datetime DEFAULT null,
  "parent_id" varchar(36) DEFAULT null
);

CREATE TABLE "product_groups" (
  "id" varchar(36) PRIMARY KEY NOT NULL,
  "name" varchar(255) NOT NULL,
  "color" varchar(255) NOT NULL,
  "comment" text DEFAULT null,
  "sort" int(11) NOT NULL DEFAULT 0,
  "is_system" tinyint(1) NOT NULL DEFAULT 0,
  "is_default" tinyint(1) NOT NULL DEFAULT 0,
  "version" int(11) NOT NULL DEFAULT 1,
  "created_at" datetime NOT NULL,
  "updated_at" datetime NOT NULL,
  "deleted_at" datetime DEFAULT null
);

CREATE TABLE "product_kit_items" (
  "id" bigint(20) PRIMARY KEY NOT NULL,
  "parent_id" varchar(36) NOT NULL,
  "kit_item_id" varchar(36) NOT NULL,
  "kit_item_name" varchar(255) NOT NULL,
  "count" int(11) NOT NULL DEFAULT 0,
  "sort" int(11) NOT NULL DEFAULT 0
);

CREATE TABLE "product_numerator" (
  "id" varchar(36) PRIMARY KEY NOT NULL,
  "entity_id" varchar(255) NOT NULL,
  "entity_name" varchar(255) NOT NULL,
  "prefix" varchar(255) DEFAULT null,
  "counter" int(11) DEFAULT 1,
  "postfix" varchar(255) DEFAULT null,
  "number" varchar(255) NOT NULL
);

CREATE TABLE "product_serials" (
  "parent_id" varchar(36) NOT NULL,
  "parent_name" varchar(255) NOT NULL,
  "id" varchar(36) PRIMARY KEY NOT NULL,
  "sku" varchar(255) NOT NULL,
  "manufacturer_number" varchar(255) DEFAULT null,
  "purchase_at" datetime NOT NULL,
  "purchase_price" int(11) NOT NULL DEFAULT 0,
  "calculate_balance_price" tinyint(1) NOT NULL DEFAULT 0,
  "start_balance_price" int(11) NOT NULL DEFAULT 0,
  "working_status" varchar(255) NOT NULL DEFAULT 'ok',
  "is_active" tinyint(1) NOT NULL DEFAULT 0,
  "sort" int(11) NOT NULL DEFAULT 0,
  "comment" varchar(255) DEFAULT null,
  "created_at" datetime NOT NULL,
  "updated_at" datetime NOT NULL,
  "deleted_at" datetime DEFAULT null,
  "version" int(11) NOT NULL DEFAULT 1
);

CREATE TABLE "product_units" (
  "for_packaging" varchar(255) NOT NULL DEFAULT 'not_used',
  "id" varchar(36) PRIMARY KEY NOT NULL,
  "name" varchar(255) NOT NULL,
  "short_name" varchar(255) NOT NULL,
  "precision" int(11) NOT NULL DEFAULT 0,
  "comment" text DEFAULT null,
  "sort" int(11) NOT NULL DEFAULT 0,
  "is_system" tinyint(1) NOT NULL DEFAULT 0,
  "is_default" tinyint(1) NOT NULL DEFAULT 0,
  "version" int(11) NOT NULL DEFAULT 1,
  "created_at" datetime NOT NULL,
  "updated_at" datetime NOT NULL,
  "deleted_at" datetime DEFAULT null
);

CREATE TABLE "users" (
  "id" int(11) PRIMARY KEY NOT NULL,
  "username" varchar(255) NOT NULL,
  "email" varchar(255) NOT NULL
);

CREATE TABLE "warehouse_inventories" (
  "id" varchar(36) PRIMARY KEY NOT NULL,
  "document_date" datetime NOT NULL,
  "number" varchar(255) NOT NULL,
  "status" varchar(255) NOT NULL,
  "comment" varchar(255) DEFAULT null,
  "created_at" datetime NOT NULL,
  "updated_at" datetime NOT NULL,
  "deleted_at" datetime DEFAULT null,
  "version" int(11) NOT NULL,
  "held" tinyint(1) NOT NULL DEFAULT 0,
  "held_at" datetime DEFAULT null,
  "held_actor_id" varchar(36) DEFAULT null,
  "location_id" varchar(36) NOT NULL,
  "created_by_id" varchar(36) DEFAULT null
);

CREATE TABLE "warehouse_inventory_rows" (
  "id" bigint(20) PRIMARY KEY NOT NULL,
  "parent_id" varchar(36) NOT NULL,
  "equipment_id" varchar(36) NOT NULL,
  "equipment_warehouse_accounting" varchar(255) NOT NULL,
  "status" varchar(10) NOT NULL DEFAULT 'not_end',
  "counted" int(11) NOT NULL DEFAULT 0,
  "stock" int(11) NOT NULL DEFAULT 0,
  "deviation" int(11) NOT NULL DEFAULT 0,
  "actor_id" varchar(36) DEFAULT null,
  "actor_name" varchar(255) DEFAULT null,
  "sort" int(11) NOT NULL DEFAULT 0,
  "created_at" datetime NOT NULL,
  "updated_at" datetime NOT NULL,
  "deleted_at" datetime DEFAULT null,
  "comment" varchar(255) DEFAULT null
);

CREATE TABLE "warehouse_inventory_row_serials" (
  "id" bigint(20) PRIMARY KEY NOT NULL,
  "row_id" bigint(20) NOT NULL,
  "serial_id" varchar(36) NOT NULL,
  "serial_s_k_u" varchar(255) NOT NULL,
  "actor_id" varchar(36) DEFAULT null,
  "current" tinyint(1) DEFAULT null,
  "created_at" datetime NOT NULL,
  "updated_at" datetime NOT NULL
);

CREATE TABLE "warehouse_numerator" (
  "id" varchar(36) PRIMARY KEY NOT NULL,
  "entity_id" varchar(255) NOT NULL,
  "entity_name" varchar(255) NOT NULL,
  "prefix" varchar(255) DEFAULT null,
  "counter" int(11) DEFAULT 1,
  "postfix" varchar(255) DEFAULT null,
  "number" varchar(255) NOT NULL
);

CREATE TABLE "warehouse_stock_balance" (
  "id" bigint(20) PRIMARY KEY NOT NULL,
  "location_id" varchar(36) NOT NULL,
  "product_id" varchar(36) NOT NULL,
  "serial_id" varchar(36) NOT NULL,
  "date" datetime NOT NULL,
  "amount" int(11) NOT NULL DEFAULT 0
);

CREATE TABLE "warehouse_stock_movement" (
  "id" bigint(20) PRIMARY KEY NOT NULL,
  "location_id" varchar(36) NOT NULL,
  "product_id" varchar(36) NOT NULL,
  "serial_id" varchar(36) NOT NULL,
  "date" datetime NOT NULL,
  "amount" int(11) NOT NULL DEFAULT 0,
  "description" varchar(255) DEFAULT null,
  "actor_id" varchar(36) DEFAULT null,
  "actor_role" varchar(32) DEFAULT null
);

CREATE TABLE "warehouse_storage_locations" (
  "id" varchar(36) PRIMARY KEY NOT NULL,
  "number" varchar(255) NOT NULL,
  "type" varchar(255) NOT NULL DEFAULT 'INTERNAL',
  "is_default" tinyint(1) NOT NULL DEFAULT 0,
  "name" varchar(255) NOT NULL DEFAULT '',
  "color" varchar(255) NOT NULL DEFAULT '#0080ff',
  "is_system" tinyint(1) NOT NULL DEFAULT 0,
  "comment" varchar(255) DEFAULT null,
  "sort" int(11) NOT NULL DEFAULT 0,
  "created_at" datetime NOT NULL,
  "updated_at" datetime DEFAULT null,
  "deleted_at" datetime DEFAULT null,
  "version" int(11) NOT NULL DEFAULT 1
);

ALTER TABLE "products" ADD CONSTRAINT "products_foreign_brand_id_67d2fa52bd5ef" FOREIGN KEY ("brand_id") REFERENCES "product_brands" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "products" ADD CONSTRAINT "products_foreign_category_id_67d2fa52bd5af" FOREIGN KEY ("category_id") REFERENCES "product_categories" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "products" ADD CONSTRAINT "products_foreign_group_id_67d2fa52bd611" FOREIGN KEY ("group_id") REFERENCES "product_groups" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "products" ADD CONSTRAINT "products_foreign_unit_id_67d2fa52bd5ce" FOREIGN KEY ("unit_id") REFERENCES "product_units" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "product_accessories" ADD CONSTRAINT "product_accessories_foreign_accessory_id_67d2fa52bd675" FOREIGN KEY ("accessory_id") REFERENCES "products" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "product_accessories" ADD CONSTRAINT "product_accessories_foreign_parent_id_67d2fa52bd544" FOREIGN KEY ("parent_id") REFERENCES "products" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "product_analogs" ADD CONSTRAINT "product_analogs_foreign_analog_id_67d2fa52bd645" FOREIGN KEY ("analog_id") REFERENCES "products" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "product_analogs" ADD CONSTRAINT "product_analogs_foreign_parent_id_67d2fa52bd568" FOREIGN KEY ("parent_id") REFERENCES "products" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "product_box_items" ADD CONSTRAINT "product_box_items_foreign_box_item_id_67d2fa52bd4a0" FOREIGN KEY ("box_item_id") REFERENCES "products" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "product_box_items" ADD CONSTRAINT "product_box_items_foreign_parent_id_67d2fa52bd482" FOREIGN KEY ("parent_id") REFERENCES "products" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "product_categories" ADD CONSTRAINT "product_categories_foreign_parent_id_67d2fa52bd693" FOREIGN KEY ("parent_id") REFERENCES "product_categories" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "product_kit_items" ADD CONSTRAINT "product_kit_items_foreign_kit_item_id_67d2fa52bd4e0" FOREIGN KEY ("kit_item_id") REFERENCES "products" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "product_kit_items" ADD CONSTRAINT "product_kit_items_foreign_parent_id_67d2fa52bd4be" FOREIGN KEY ("parent_id") REFERENCES "products" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "product_serials" ADD CONSTRAINT "product_serials_foreign_parent_id_67d2fa52bd447" FOREIGN KEY ("parent_id") REFERENCES "products" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "warehouse_inventories" ADD CONSTRAINT "warehouse_inventories_foreign_location_id_67d2fa52bd6de" FOREIGN KEY ("location_id") REFERENCES "warehouse_storage_locations" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "warehouse_inventory_rows" ADD CONSTRAINT "warehouse_inventory_rows_foreign_parent_id_67d2fa52bd6fb" FOREIGN KEY ("parent_id") REFERENCES "warehouse_inventories" ("id") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "warehouse_inventory_row_serials" ADD CONSTRAINT "warehouse_inventory_row_serials_foreign_row_id_67d2fa52bd719" FOREIGN KEY ("row_id") REFERENCES "warehouse_inventory_rows" ("id") ON DELETE CASCADE ON UPDATE CASCADE;
