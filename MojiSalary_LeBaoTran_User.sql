use testtrigger_moji

---------------1. Thiết lập các nhóm người dùng hệ thống 
create role QuanLyCuaHang
create role KeToanLuong
create role NhanVien
create role NhanVienKyThuat

---------------Cấp quyền cho nhân viên: select cho các bảng Bảng chấm công và bảng Nhân viên 
grant select on tbl_BANGCHAMCONG to NhanVien
grant select on tbl_NHANVIEN to NhanVien

-- Cấp quyền cho nhân viên kỹ thuật: select, insert, update, control cho các bảng trong cơ sở dữ liệu
-- CÓ THỂ PHÂN QUYỀN CHO NGƯỜI KHÁC
grant control on  SalaryMoji_4330 to NhanVienKyThuat 
/*Cấp quyền cho quản lý cửa hàng: insert, update, delete 
cho các bảng Bảng chấm công, bảng Nhân viên, bảng Chức vụ, bảng Phòng ban, bảng Cơ sở.*/
grant select, insert, update, delete on tbl_NHANVIEN to QuanLyCuaHang
grant select, insert, update, delete on tbl_BANGCHAMCONG to QuanLyCuaHang
grant select, insert, update, delete on tbl_CHUCVU to QuanLyCuaHang
grant select, insert, update, delete on tbl_PHONGBAN to QuanLyCuaHang
grant select, insert, update, delete on tbl_COSO to QuanLyCuaHang
grant select, insert, update, delete on tbl_PHONGBAN to QuanLyCuaHang
/*Cấp quyền cho quản lý cửa hàng: insert, update, delete 
cho các bảng Bảng Lương, bảng Bổ sung lương, bảng Khấu trừ.*/
grant select, insert, update, delete on tbl_BANGLUONG to KeToanLuong
grant select, insert, update, delete on tbl_BOSUNG to KeToanLuong
grant select, insert, update, delete on tbl_KHAUTRU to KeToanLuong






