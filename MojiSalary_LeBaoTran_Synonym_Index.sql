
use SalaryMoji_4330
---INDEX 

--1. TẠO CHỈ MỤC CHỨC VỤ QUA TÊN CHỨC VỤ
create index IndexChucVu on tbl_CHUCVU(TenChucVu)

--2. TẠO CHỈ MỤC NHÂN VIÊN QUA HỌ VÀ TÊN NHÂN VIÊN
create index IndexNhanVien on tbl_NHANVIEN(HoNV,TenNV)

--3. TẠO CHỈ MỤC CƠ SỞ QUA TÊN CƠ SỞ 
create index IndexCoSo on tbl_COSO(TenCS)


-- 1. TÌM HỆ SỐ LƯƠNG QUA CHỨC VỤ NHÂN VIÊN
select * from tbl_CHUCVU with (index (IndexChucVu)) where TenChucVu='Nhan vien ban hang full time'

--2. TÌM CƠ SỞ LÀM VIỆC CỦA 1 NHÂN VIÊN
select nv.MaNV, nv.TenNV, cs.TenCS
from tbl_COSO cs with (index (IndexCoSo))  join tbl_NHANVIEN nv  with (index (IndexNhanVien))  on cs.MaCS=nv.MaCS
where nv.TenNV='Tran'

--3. TÌM QUẢN LÝ CỦA NHÂN VIÊN CỦA CỬA HÀNG (THUỘC CÙNG 1 CƠ SỞ) CỦA 1 NHÂN VIÊN QUA TÊN CỦA NHÂN VIÊN ĐÓ
select nv.MaNV,nv.HoNV+' '+nv.TenNV as HoTenNV,nv.MaCS, cs.TenCS, nv.MaChucVu, cv.TenChucVu
from tbl_NHANVIEN nv  with (index (IndexNhanVien)) join tbl_CHUCVU cv with (index (IndexChucVu))  on nv.MaChucVu =cv.MaChucVu
join tbl_COSO cs with (index (IndexCoSo))  on nv.MaCS=cs.MaCS
where  cv.MaChucVu= 'CV02' and cs.MaCS = (select MaCS from   tbl_NHANVIEN where HoNV='Nguyen Van' and TenNV='An')


--SYNONYM 

--1. TẠO TÊN ĐỒNG NGHĨA CHO BẢNG NHÂN VIÊN
create synonym Staffing for tbl_NHANVIEN


--TRUY XUẤT CÁC KHOẢN KHẤU TRỪ TRỪ THU NHẬP CỦA CÁC NHÂN VIÊN
select * from Staffing

--2.TẠO TÊN ĐỒNG NGHĨA CHO BẢNG CHẤM CÔNG
create synonym Timesheet for tbl_BANGCHAMCONG

--TRUY XUẤT BẢNG CHẤM CÔNG CỦA CÁC NHÂN VIÊN
select *from Timesheet

--3. TẠO TÊN ĐỒNG NGHĨA CHO BẢNG LƯƠNG
create synonym Payroll for tbl_BANGLUONG

--TRUY XUẤT BẢNG LƯƠNG CỦA CÁC NHÂN VIÊN
select* from Payroll


--TRUY XUẤT DANH SÁCH SYNONYM HIỆN CÓ TRONG DOANH NGHIỆP MOJI 
select name, base_object_name type
from sys.synonyms
order by name

