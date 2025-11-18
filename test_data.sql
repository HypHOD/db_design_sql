-- 1. 插入用户数据（普通用户+卖家，密码统一为 123456，加密后存储为示例）
INSERT INTO
    user_info (
        user_student_id,
        user_password,
        user_name,
        user_college,
        user_email,
        user_avatar
    )
VALUES (
        '2023001',
        'e10adc3949ba59abbe56e057f20f883e',
        '张三',
        '计算机学院',
        'zhangsan@xxx.edu',
        'avatar-zhangsan.jpg'
    ),
    (
        '2023002',
        'e10adc3949ba59abbe56e057f20f883e',
        '李四',
        '经管学院',
        'lisi@xxx.edu',
        'avatar-lisi.jpg'
    ),
    (
        '2023003',
        'e10adc3949ba59abbe56e057f20f883e',
        '王五',
        '文学院',
        'wangwu@xxx.edu',
        'default-avatar.jpg'
    ),
    (
        '2023004',
        'e10adc3949ba59abbe56e057f20f883e',
        '赵六',
        '工学院',
        'zhaoliu@xxx.edu',
        'avatar-zhaoliu.jpg'
    );

-- 2. 插入商品分类数据
INSERT INTO
    category (
        category_name,
        category_sort_order
    )
VALUES ('电子产品', 1),
    ('书籍教材', 2),
    ('生活用品', 3),
    ('体育器材', 4),
    ('美妆护肤', 5);

-- 3. 插入商品数据（关联用户和分类，状态说明：0-待审核，1-已上架，2-已下架，3-已售出）
INSERT INTO
    product (
        user_id,
        category_id,
        product_title,
        product_original_price,
        product_current_price,
        product_status,
        quality
    )
VALUES (
        1,
        1,
        '2022款 MacBook Pro 14寸（8+512G）',
        12999,
        9999,
        1,
        2
    ), -- 张三卖电子产品（9成新）
    (
        2,
        2,
        '《数据结构（C语言版）》考研真题解析',
        68,
        35,
        1,
        1
    ), -- 李四卖书籍（全新）
    (
        3,
        3,
        '小米空气净化器4 Pro',
        1499,
        899,
        1,
        2
    ), -- 王五卖生活用品（9成新）
    (
        4,
        4,
        '尤尼克斯羽毛球拍（天斧99）',
        1780,
        1200,
        1,
        2
    ), -- 赵六卖体育器材（8.5成新）
    (
        1,
        5,
        '雅诗兰黛小棕瓶精华50ml',
        890,
        550,
        1,
        1
    );
-- 张三卖美妆（全新未拆）

-- 4. 插入商品图片数据（每个商品1-2张图）
INSERT INTO
    product_image (
        product_id,
        image_url,
        sort_order
    )
VALUES (
        1,
        'https://img.example.com/macbook1.jpg',
        0
    ),
    (
        1,
        'https://img.example.com/macbook2.jpg',
        1
    ),
    (
        2,
        'https://img.example.com/book1.jpg',
        0
    ),
    (
        3,
        'https://img.example.com/purifier1.jpg',
        0
    ),
    (
        4,
        'https://img.example.com/badminton1.jpg',
        0
    ),
    (
        5,
        'https://img.example.com/estee1.jpg',
        0
    );

-- 5. 插入地址数据（每个用户1-2个地址，含默认地址）
INSERT INTO
    address (
        user_id,
        receiver_name,
        receiver_phone,
        receiver_address,
        is_default
    )
VALUES (
        1,
        '张三',
        '13800138001',
        '北京市海淀区中关村大街59号（xxx宿舍）',
        1
    ),
    (
        1,
        '张三',
        '13800138001',
        '北京市朝阳区建国路88号',
        0
    ),
    (
        2,
        '李四',
        '13900139002',
        '上海市浦东新区张江高科技园区',
        1
    ),
    (
        3,
        '王五',
        '13700137003',
        '广州市天河区天河路385号',
        1
    ),
    (
        4,
        '赵六',
        '13600136004',
        '深圳市南山区科技园',
        1
    );

-- 6. 插入购物车数据（用户2收藏商品1、3；用户3收藏商品4）
INSERT INTO
    cart (user_id, product_id)
VALUES (2, 1), -- 李四把张三的MacBook加入购物车
    (2, 3), -- 李四把王五的空气净化器加入购物车
    (3, 4);
-- 王五把赵六的羽毛球拍加入购物车

-- 7. 插入收藏数据（用户3收藏商品1、5；用户4收藏商品2）
INSERT INTO
    favorite (user_id, product_id)
VALUES (3, 1), -- 王五收藏张三的MacBook
    (3, 5), -- 王五收藏张三的小棕瓶
    (4, 2);
-- 赵六收藏李四的考研书

-- 8. 插入订单数据（状态说明：0-待付款，1-已付款，2-已发货，3-已收货，4-已取消，5-退款中）
INSERT INTO
    user_order (
        user_id,
        seller_id,
        product_id,
        product_title,
        product_image,
        price,
        order_status,
        create_time,
        pay_time
    )
VALUES (
        2,
        1,
        1,
        '2022款 MacBook Pro 14寸（8+512G）',
        'https://img.example.com/macbook1.jpg',
        9999.00,
        2,
        '2025-10-01 10:30:00',
        '2025-10-01 11:05:00'
    ), -- 李四买张三的MacBook（已发货）
    (
        4,
        2,
        2,
        '《数据结构（C语言版）》考研真题解析',
        'https://img.example.com/book1.jpg',
        35.00,
        3,
        '2025-10-02 14:20:00',
        '2025-10-02 14:30:00'
    ), -- 赵六买李四的书（已收货）
    (
        1,
        3,
        3,
        '小米空气净化器4 Pro',
        'https://img.example.com/purifier1.jpg',
        899.00,
        1,
        '2025-10-03 09:15:00',
        '2025-10-03 09:20:00'
    ), -- 张三买王五的净化器（已付款）
    (
        3,
        4,
        4,
        '尤尼克斯羽毛球拍（天斧99）',
        'https://img.example.com/badminton1.jpg',
        1200.00,
        0,
        '2025-10-04 16:40:00',
        NULL
    );
-- 王五买赵六的球拍（待付款）

-- 9. 插入评论数据（仅已完成订单可评论，评分1-10）
INSERT INTO
    comment (
        order_id,
        user_id,
        seller_id,
        comment_content,
        rating,
        comment_status
    )
VALUES (
        2,
        4,
        2,
        '书籍印刷清晰，真题解析很详细，非常适合考研复习！',
        10,
        0
    ), -- 赵六评论李四的书
    (
        1,
        2,
        1,
        '电脑成色很新，性能完全没问题，卖家发货很快～',
        9,
        0
    );
-- 李四评论张三的MacBook

-- 10. 插入自提预约数据（关联订单和地址，状态：0-待确认，1-已确认，2-已完成，3-已取消）
INSERT INTO
    reserve (
        order_id,
        user_id,
        seller_id,
        address_id,
        reserve_status,
        create_time,
        finish_time
    )
VALUES (
        2,
        4,
        2,
        4,
        2,
        '2025-10-02 15:00:00',
        '2025-10-03 10:00:00'
    ), -- 赵六预约自提李四的书（已完成）
    (
        1,
        2,
        1,
        2,
        1,
        '2025-10-01 11:10:00',
        NULL
    );
-- 李四预约自提张三的MacBook（已确认）

-- 11. 插入浏览历史记录
INSERT INTO
    record (
        user_id,
        product_id,
        create_time
    )
VALUES (2, 5, '2025-10-01 09:20:00'), -- 李四浏览张三的小棕瓶
    (3, 2, '2025-10-02 11:30:00'), -- 王五浏览李四的考研书
    (4, 3, '2025-10-03 14:10:00'), -- 赵六浏览王五的净化器
    (1, 4, '2025-10-04 15:50:00');
-- 张三浏览赵六的羽毛球拍

-- 12. 插入系统公告数据
INSERT INTO
    b_notice (notice_content, sort_value)
VALUES (
        '【重要通知】校园二手交易平台10月20日系统维护，维护期间暂停服务，敬请谅解！',
        10
    ),
    (
        '【活动通知】双十一二手商品促销活动开始啦，全场低至5折，快来选购～',
        8
    ),
    (
        '【安全提示】交易时请选择线下自提，当面验货，谨防诈骗！',
        5
    );

-- 13. 插入用户登录日志
INSERT INTO
    b_login (
        user_id,
        login_time,
        ip_address,
        login_device,
        login_status
    )
VALUES (
        1,
        '2025-10-01 08:30:00',
        '192.168.1.101',
        'iPhone 15',
        TRUE
    ),
    (
        2,
        '2025-10-01 09:15:00',
        '192.168.1.102',
        'MacBook Pro',
        TRUE
    ),
    (
        3,
        '2025-10-01 10:00:00',
        '192.168.1.103',
        '华为Mate 60',
        TRUE
    ),
    (
        4,
        '2025-10-01 10:45:00',
        '192.168.1.104',
        'Windows PC',
        FALSE
    );
-- 登录失败

-- 14. 插入操作日志（管理员/用户操作记录）
INSERT INTO
    b_op (
        user_id,
        op_time,
        op_type,
        op_object,
        op_detail
    )
VALUES (
        1,
        '2025-10-01 09:00:00',
        '发布商品',
        '商品ID:1',
        '发布2022款MacBook Pro，分类：电子产品'
    ),
    (
        2,
        '2025-10-01 11:05:00',
        '支付订单',
        '订单ID:1',
        '支付MacBook Pro订单，金额9999.00元'
    ),
    (
        3,
        '2025-10-02 15:00:00',
        '创建预约',
        '预约ID:1',
        '预约自提《数据结构》考研书'
    ),
    (
        4,
        '2025-10-03 10:00:00',
        '发表评论',
        '评论ID:1',
        '评论订单ID:2的商品，评分10分'
    );

-- 15. 插入错误日志
INSERT INTO
    b_error (
        user_id,
        error_type,
        error_code,
        error_message,
        handle_status
    )
VALUES (
        4,
        '登录错误',
        401,
        '用户名或密码错误，连续尝试3次失败',
        '未处理'
    ),
    (
        1,
        '商品发布',
        500,
        '上传商品图片时服务器存储异常',
        '已处理'
    ),
    (
        2,
        '订单支付',
        403,
        '支付接口调用失败，余额不足',
        '未处理'
    );