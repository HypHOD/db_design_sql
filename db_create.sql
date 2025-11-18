-- 需要手动数据库
-- >psql -d postgres;
-- >CREATE DATABASE campus_shop;

-- 使用数据库
-- >\c campus_shop;

-- create table user
CREATE TABLE IF NOT EXISTS user_info (
    user_id SERIAL PRIMARY KEY,
    user_student_id VARCHAR(20) UNIQUE NOT NULL,
    user_password VARCHAR(50) NOT NULL,
    user_name VARCHAR(20) NOT NULL,
    user_college VARCHAR(20),
    user_email VARCHAR(100) UNIQUE NOT NULL,
    user_create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_status SMALLINT DEFAULT 1,
    user_avatar VARCHAR(255) DEFAULT 'default-avatar.jpg'
);

-- create table category
CREATE TABLE IF NOT EXISTS category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE NOT NULL,
    category_sort_order SMALLINT DEFAULT 0,
    category_create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create table product
CREATE TABLE IF NOT EXISTS product (
    product_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES user_info (user_id) ON DELETE CASCADE,
    category_id INT REFERENCES category (category_id) ON DELETE SET NULL,
    product_title VARCHAR(255) NOT NULL,
    product_original_price INT NOT NULL,
    product_current_price INT NOT NULL,
    product_status SMALLINT NOT NULL DEFAULT 0,
    quality SMALLINT DEFAULT 1,
    reject_reason VARCHAR(255),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    update_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create table prodcut_image
CREATE TABLE IF NOT EXISTS product_image (
    image_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL REFERENCES product (product_id),
    image_url VARCHAR(255) NOT NULL,
    sort_order SMALLINT DEFAULT 0,
    FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE
);
-- create table address
CREATE TABLE IF NOT EXISTS address (
    address_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES user_info (user_id) ON DELETE CASCADE,
    receiver_name VARCHAR(50) NOT NULL,
    receiver_phone VARCHAR(20) NOT NULL,
    receiver_address VARCHAR(255) NOT NULL,
    is_default SMALLINT DEFAULT 0,
    UNIQUE (address_id)
);
-- create table cart
CREATE TABLE IF NOT EXISTS cart (
    cart_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES user_info (user_id),
    product_id INT NOT NULL REFERENCES product (product_id),
    add_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- create table favorite
CREATE TABLE IF NOT EXISTS favorite (
    favorite_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES user_info (user_id),
    product_id INT NOT NULL REFERENCES product (product_id),
    add_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, product_id)
);

-- create table order
CREATE TABLE IF NOT EXISTS user_order (
    order_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES user_info (user_id),
    seller_id INT NOT NULL REFERENCES user_info (user_id),
    product_id INT UNIQUE NOT NULL REFERENCES product (product_id),
    product_title VARCHAR(255) NOT NULL,
    product_image VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    order_status SMALLINT NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    pay_time TIMESTAMP,
    receive_time TIMESTAMP,
    cancel_time TIMESTAMP,
    refund_reason VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE,
    CHECK (user_id <> seller_id)
);
-- create table comment
CREATE TABLE IF NOT EXISTS comment (
    comment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES user_order (order_id),
    user_id INT NOT NULL REFERENCES user_info (user_id),
    seller_id INT NOT NULL REFERENCES user_info (user_id),
    comment_content VARCHAR(1000),
    rating SMALLINT DEFAULT 10,
    comment_status SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
    UNIQUE (order_id)
);
-- create table reserve
CREATE TABLE IF NOT EXISTS reserve (
    reserve_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL REFERENCES user_order (order_id),
    user_id INT NOT NULL REFERENCES user_info (user_id),
    seller_id INT NOT NULL REFERENCES user_info (user_id),
    address_id INT NOT NULL REFERENCES address (address_id),
    reserve_status SMALLINT DEFAULT 0,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    finish_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
    FOREIGN KEY (seller_id) REFERENCES user_info (user_id) ON DELETE CASCADE,
    FOREIGN KEY (address_id) REFERENCES address (address_id) ON DELETE CASCADE,
    UNIQUE (order_id)
);
-- create table record 历史记录
CREATE TABLE IF NOT EXISTS record (
    record_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES user_info (user_id),
    product_id INT NOT NULL REFERENCES product (product_id),
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES product (product_id) ON DELETE CASCADE,
    UNIQUE (user_id, product_id)
);
-- create table b_notice
CREATE TABLE IF NOT EXISTS b_notice (
    b_notice_id SERIAL PRIMARY KEY,
    notice_content VARCHAR(1000) NOT NULL,
    create_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    sort_value SMALLINT DEFAULT 0
);
-- create table b_login
CREATE TABLE IF NOT EXISTS b_login (
    b_login_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES user_info (user_id),
    login_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(50),
    login_device VARCHAR(100),
    login_status BOOLEAN,
    FOREIGN KEY (user_id) REFERENCES user_info (user_id) ON DELETE CASCADE
);
-- create table b_op
CREATE TABLE IF NOT EXISTS b_op (
    b_op_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES user_info (user_id),
    op_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    op_type VARCHAR(20),
    op_object VARCHAR(100),
    op_detail TEXT,
    FOREIGN KEY (user_id) REFERENCES user_info (user_id) ON DELETE RESTRICT
);
-- create table b_error
CREATE TABLE IF NOT EXISTS b_error (
    b_error_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES user_info (user_id),
    error_type VARCHAR(50) NOT NULL,
    error_code SMALLINT NOT NULL,
    error_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    error_message TEXT NOT NULL,
    handle_status VARCHAR(20) NOT NULL DEFAULT '未处理',
    handle_time TIMESTAMP,
    handle_detail TEXT,
    FOREIGN KEY (user_id) REFERENCES user_info (user_id) ON DELETE RESTRICT
);

-- 创建索引
CREATE INDEX idx_product_category ON product (category_id);

CREATE INDEX idx_product_user ON product (user_id);

CREATE INDEX idx_order_user ON user_order (user_id);

CREATE INDEX idx_order_seller ON user_order (seller_id);

CREATE INDEX idx_comment_user ON comment (user_id);

CREATE INDEX idx_comment_seller ON comment (seller_id);

CREATE INDEX idx_reserve_user ON reserve (user_id);

CREATE INDEX idx_reserve_seller ON reserve (seller_id);

CREATE INDEX idx_reserve_address ON reserve (address_id);

-- 部分唯一索引：每个用户只能有一个 is_default = 1 的地址
CREATE UNIQUE INDEX IF NOT EXISTS ux_address_user_default ON address (user_id)
WHERE (is_default = 1);

-- 返回当前时间戳
CREATE OR REPLACE FUNCTION get_current_timestamp()
RETURNS TIMESTAMP AS $$
BEGIN
    RETURN CURRENT_TIMESTAMP;
END;
$$ LANGUAGE plpgsql STABLE;
-- 标记为 STABLE（允许在生成列中使用）