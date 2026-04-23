-- 2 giải pháp DDL để xử lý bài toán này là
-- - thứ nhất là thay đổi trực tiếp kiểu dữ liệu cột từ int bằng varchar(15). Ưu điểm là đơn giản.Nhược điểm là rủi ro mất dữ liệu, Ảnh hưởng nhiều đến hệ thống 
-- - Hai là Thêm một cột mới với kiểu là varchar(15) - Copy dữ liệu từ cột cũ - xóa cột cũ đó - Rồi đổi lại tên cột mới bằng tên cột cũ. Ưu điểm là ít rủi ro mất dữ liệu, ít ảnh hưởng hệ thống, dễ rollback. Nhược điểm là phức tạp hơn
-- ->Chốt giải pháp hai 


USE USERS;
DROP TABLE IF EXISTS UserTable;

CREATE TABLE UserTable (
	id_user INT PRIMARY KEY,
	phone_number VARCHAR(10) UNIQUE NOT NULL,
    user_name VARCHAR(50) NOT NULL
);

-- 1. Thêm cột mới (KHÔNG lock lâu)
ALTER TABLE UserTable ADD COLUMN phone_new VARCHAR(15);
SET SQL_SAFE_UPDATES = 0;
-- 2. Migrate dữ liệu (có thể chạy batch nếu cần)
UPDATE UserTable 
SET phone_new = CAST(phone_number AS CHAR);
SET SQL_SAFE_UPDATES = 1;
-- 3. Đổi tên cột (downtime rất ngắn)
ALTER TABLE UserTable 
DROP COLUMN phone_number,
CHANGE phone_new Phone VARCHAR(15);