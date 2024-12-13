use SalaryMoji_4330
use testnewdata


---TRUY VẤN CƠ BẢN

--1. CHO BIẾT NHÂN VIÊN CÓ THÂM NIÊN TRÊN 5 NĂM 
--TRONG KỲ LƯƠNG THÁNG 5/2024
create view vw_ThamNien
as
select MaNV, HoNV+' '+TenNV as HoTenNV, year(getdate())-year(NgayVaoLam) as ThamNien
from tbl_NHANVIEN 
where year(getdate())-year(NgayVaoLam) >=5

----KIỂM THỬ VIEW1
select * from vw_ThamNien

--2. DANH SÁCH NHÂN VIÊN THEO TỪNG CƠ SỞ 
create view vw_DSNV_CS
as
select cs.MaCS, cs.TenCS, nv.MaNV, HoNV+' '+TenNV as HoTenNV, cv.TenChucVu
from tbl_NHANVIEN nv join tbl_COSO cs on nv.MaCS=cs.MaCS 
join tbl_CHUCVU cv on nv.MaChucVu =cv.MaChucVu

----KIỂM THỬ VIEW2
select * from vw_DSNV_CS

--3.THỐNG KÊ SỐ LƯỢNG NHÂN VIÊN CỦA MỖI CƠ SỞ
create view vw_SoLuongNV
as 
select nv.MaCS, cs.TenCS, count(nv.MaNV) as SoLuongNV
from tbl_NHANVIEN nv join tbl_COSO cs on nv.MaCS=cs.MaCS
group by nv.MaCS, cs.TenCS

-----KIỂM THỬ VIEW 3
select * from vw_SoLuongNV

/*
-----ĐẾM SỐ LƯỢNG NHÂN VIÊN BÁN HÀNG FULL TIME CỦA MỖI CƠ SỞ
create view vw_SLNV_CS
as
select nv.MaCS, cs.TenCS, count (nv.MaNV) as SLNV
from tbl_NHANVIEN nv join tbl_COSO cs on nv.MaCS=cs.MaCS
where nv.MaChucVu ='CV01'
group by nv.MaCS, cs.TenCS

-----KIỂM THỬ VIEW 4
select * from vw_SLNV_CS */

--4.CHO BIẾT NHỮNG NHÂN VIÊN CÓ THỜI GIAN LÀM VIỆC KHÔNG ĐẠT 
--THỜI GIAN LÀM VIỆC TIÊU CHUẨN TRONG KỲ LƯƠNG THÁNG 5/2024
create view vw_TGLV_T5
as
select nv.MaNV, nv.HoNV+' '+nv.TenNV as HoTenNV, sum(ct.SoLan) as TGLV_T5, cv.TGLVTC
from tbl_NHANVIEN nv join tbl_BANGCHAMCONG bcc on nv.MaNV=bcc.MaNV
join tbl_CHUCVU cv on nv.MaChucVu=cv.MaChucVu
join tbl_CTBCC ct on bcc.MaBCC=ct.MaBCC
where bcc.thang=5 and bcc.nam=2024  
group by nv.MaNV, nv.HoNV,nv.TenNV, cv.TGLVTC 
having sum(ct.SoLan)<cv.TGLVTC 

------KIỂM THỬ VIEW 4
select * from vw_TGLV_T5


--5.NHÂN VIÊN CÓ SỐ THỜI GIAN LÀM VIỆC NHIỀU NHẤT KỲ 5/2024.
create view vw_MAX_TGLV
as 
with TongTGLV as (
select nv.MaNV, nv.MaChucVu ,nv.HoNV+' '+nv.TenNV as HoTenNV, sum(ct.SoLan) as TGLVlonnhat
from tbl_BANGCHAMCONG bcc join tbl_NHANVIEN nv on bcc.MaNV =nv.MaNV
join tbl_CTBCC ct on bcc.MaBCC=ct.MaBCC
group by nv.MaChucVu, nv.MaNV,nv.HoNV,nv.TenNV)
select MaNV, MaChucVu ,HoTenNV, TGLVlonnhat
from TongTGLV
where TGLVlonnhat = (select top 1 TGLVlonnhat 
from TongTGLV 
order by TGLVlonnhat desc 
)
----KIỂM THỬ VIEW 5
select * from vw_MAX_TGLV


