use SalaryMoji_4330
use testnewdata

/*----1.TÍNH TỔNG KHOẢN KỶ LUẬT CỦA MỖI NHÂN VIÊN TRONG KỲ LƯƠNG THÁNG 05/2024
create proc sp_KYLUAT @thang int, @nam int
as 
begin
select bl.MaNV, bl.MaLuong , sum(ct.HeSoKT*kt.KhoanKT) as "Tong khoan khau tru"
from tbl_CTKHAUTRU ct join tbl_KHAUTRU kt on ct.MaKT=kt.MaKT
join tbl_BANGLUONG bl on ct.MaLuong=bl.MaLuong
join tbl_KYLUONG kl on bl.MaKL=kl.MaKL
where ct.MaKT in ('KT04', 'KT05','KT06','KT07') and kl.Thang = @thang and kl.Nam = @nam
group by bl.MaLuong, bl.MaNV
end 

---KIỂM THỬ	
exec sp_KYLUAT 05, 2024

----2.TÍNH TỔNG KHOẢN BẢO HIỂM  CỦA MỖI NHÂN VIÊN TRONG KỲ LƯƠNG THÁNG 05/2024
create proc sp_BAOHIEM @thang int, @nam int
as 
begin
select bl.MaNV, bl.MaLuong , sum(((cv.HeSoLuong*bcc.TGlamviec*cv.LuongCB)+bs.KhoanBS)*(ct.HeSoKT*kt.KhoanKT)) as "Tong bao hiem"
from tbl_CTKHAUTRU ct join tbl_KHAUTRU kt on ct.MaKT=kt.MaKT
join tbl_BANGLUONG bl on ct.MaLuong=bl.MaLuong
join tbl_KYLUONG kl on bl.MaKL=kl.MaKL
join tbl_BANGCHAMCONG bcc on bl.MaNV=bcc.MaNV
join tbl_CHUCVU cv on bcc.MaChucVu=cv.MaChucVu
join tbl_CTBOSUNG ctbs on bl.MaLuong = ctbs.MaLuong
join tbl_BOSUNG bs on ctbs.MaBS=bs.MaBS
where ct.MaKT in ('KT01', 'KT02','KT03') and kl.Thang = @thang and kl.Nam = @nam and ctbs.MaBS in ('BS03','BS04')
group by bl.MaLuong, bl.MaNV
end 

exec sp_BAOHIEM 05, 2024


----------3.TÍNH TỔNG KHOẢN PHỤ CẤP CỦA MỖI NHÂN VIÊN TRONG KỲ LƯƠNG THÁNG .../.... 
create proc sp_PHUCAP @thang int, @nam int
as
begin 
select bl.MaLuong, bl.MaNV, sum(ctbs.HeSoBS*bs.KhoanBS) as "Tong khoan phu cap 1"
from tbl_CTBOSUNG ctbs join tbl_BANGLUONG bl on ctbs.MaLuong=bl.MaLuong
join tbl_BOSUNG bs on ctbs.MaBS=bs.MaBS
join tbl_KYLUONG kl on bl.MaKL=kl.MaKL
where ctbs.MaBS in ('BS01','BS02', 'BS03', 'BS04') and kl.Thang = @thang and kl.Nam = @nam
group by bl.MaLuong, bl.MaNV
end

exec sp_PHUCAP 05, 2024
*/

----1. CẬP NHẬP HỆ SỐ LƯƠNG CHO NHÂN VIÊN CÓ THÂM NIÊN 
--TỪ 5 NĂM TRỞ LÊN THEO MÃ SỐ CHỨC VỤ
create proc sp_uHeSoCV @MaCV nchar(5),  @HSCV float
as 
begin
	update tbl_CHUCVU 
	set HeSoLuong = @HSCV
	from tbl_NHANVIEN nv join tbl_CHUCVU cv on nv.MaChucVu=cv.MaChucVu
	where year(getdate())-year(Ngayvaolam)>=5 and nv.MaChucVu=@MaCV
end

--KIỂM THỬ
exec sp_uHeSoCV @MaCV='CV01',@HSCV=1.2

--KẾT QUẢ KIỂM THỬ
select nv.MaNV, nv.MaChucVu,CV.HeSoLuong,  year(getdate())-year(nv.Ngayvaolam) as thamnien
from tbl_NHANVIEN NV JOIN tbl_CHUCVU CV ON NV.MaChucVu=CV.MaChucVu
where year(getdate())-year(nv.Ngayvaolam) >=5

drop proc  sp_uHeSoCV

/*2.TRỪ 20.000Đ/ Mỗi ca Nhân viên nào nghỉ quá thời gian làm việc tiêu chuẩn. 
Tính tổng khoản trừ các nhân viên không làm việc đủ tiêu chuẩn*/
create proc sp_NVthieuTGLV @Thang int, @Nam int
as
begin
select nv.HoNV+' '+nv.TenNV as HoTenNV, cv.TenChucVu,cv.TGLVTC,
sum(ct.SoLan) as TGLV_T5, (20000*(cv.TGLVTC- sum(ct.SoLan))) as TongKhoanTruLamThieuTGLV
from tbl_NHANVIEN nv join tbl_BANGCHAMCONG bcc on nv.MaNV=bcc.MaNV
join tbl_CHUCVU cv on nv.MaChucVu=cv.MaChucVu
join tbl_CTBCC ct on bcc.MaBCC=ct.MaBCC
where bcc.thang=@Thang and bcc.nam=@Nam
group by nv.HoNV,nv.TenNV,cv.TenChucVu, cv.TGLVTC
having sum(ct.SoLan)<cv.TGLVTC ;
end 

--KIỂM THỬ 
exec sp_NVthieuTGLV @Thang=5, @Nam=2024

--3. CẬP NHẬT KHOẢN NGOÀI LƯƠNG THEO MÃ KHOẢN NGOÀI LƯƠNG 
--(CÁC KHOẢN NHƯ BẢO HIỂM, PHỤ CẤP, THƯỞNG, KỶ LUẬT)
create proc sp_uKNL @MaKNL nchar(5), @KhoanNL float
as
begin
update tbl_KHOANNGOAILUONG
set KhoanNL = @KhoanNL
where @MaKNL = MaKNL
end

--KIỂM THỬ
exec sp_uKNL @MaKNL='T01', @KhoanNL=80000

select * from tbl_KHOANNGOAILUONG where MaKNL = 'T01'




--4. DANH SÁCH NHÂN VIÊN THEO NĂM CỦA THỜI GIAN VÀO LÀM
create proc sp_DSNVtheoNam @Nam int
as 
begin
select nv.HoNV+' '+nv.TenNV as HoTenNV, cv.TenChucVu, cs.TenCS, nv.NgayVaoLam
from tbl_NHANVIEN nv join tbl_CHUCVU cv on nv.MaChucVu=cv.MaChucVu
join tbl_COSO cs on nv.MaCS=cs.MaCS
where @Nam=year(nv.NgayVaoLam)
end 

--KIỂM THỬ 
exec sp_DSNVtheoNam @Nam=2021



--5. THỐNG KÊ NHÂN VIÊN THEO TÊN CHỨC VỤ 
create proc sp_DSNV_ChucVu @TenChucVu nvarchar(35)
as
begin 
select  nv.HoNV+' '+nv.TenNV as HoTenNV, cv.TenChucVu, cs.TenCS
from tbl_NHANVIEN nv join tbl_CHUCVU cv on nv.MaChucVu=cv.MaChucVu
join tbl_COSO cs on nv.MaCS =cs.MaCS
where @TenChucVu = cv.TenChucVu 
end 




--KIỂM THỬ 
exec sp_DSNV_ChucVu @TenChucVu='Nhan Vien Ban Hang full time'

--6. THỐNG KÊ NHÂN VIÊN THEO CA LÀM (ĐẦU CA - KẾT CA)
create proc sp_DSNV_CaLam @DauCa time, @KetCa time
as 
begin 
select  nv.HoNV+' '+nv.TenNV as HoTenNV, cv.TenChucVu, cs.TenCS, ct.MaCL, ct.SoLan
from tbl_NHANVIEN nv join tbl_CHUCVU cv on nv.MaChucVu=cv.MaChucVu
join tbl_COSO cs on nv.MaCS =cs.MaCS
join tbl_BANGCHAMCONG bcc on nv.MaNV=bcc.MaNV
join tbl_CTBCC ct on bcc.MaBCC=ct.MaBCC
join tbl_CALAM cl on ct.MaCL=cl.MaCL
where @DauCa=cl.DauCa and @KetCa=cl.KetCa
end 



--KIỂM THỬ
exec sp_DSNV_CaLam @DauCa= '8:00:00', @KetCa= '18:00:00'

/* 7. THÔNG BÁO "CÒN LÀM" CHO NHÂN VIÊN CÓ SỐ CA LÀM >0 HOẶC KHÔNG TÌM THẤY NHÂN VIÊN TRONG BẢNG CHI TIẾT BẢNG CHẤM CÔNG.
THÔNG BÁO "ĐÃ NGHỈ" CHO NHÂN VIÊN KHÔNG CÓ CA LÀM NÀO TRONG THÁNG .../.....*/
create proc sp_TrangThaiNhanVien @MaNV nchar(5), @Nam int, @Thang int
as 
begin 
declare @SoCa int, @HoTen nvarchar(50), @CV nvarchar(35), @CS nvarchar(50)
select @SoCa = sum(ct.SoLan) 
from tbl_CTBCC ct join tbl_BANGCHAMCONG bcc on ct.MaBCC=bcc.MaBCC
where @MaNV=bcc.MaNV and @Nam=bcc.Nam and @Thang=bcc.Thang
select @HoTen = nv.HoNV+' '+nv.TenNV, @CV=cv.TenChucVu, @CS=cs.TenCS
from tbl_CTBCC ct join tbl_BANGCHAMCONG bcc on ct.MaBCC=bcc.MaBCC
join tbl_NHANVIEN nv on bcc.MaNV=nv.MaNV
join tbl_CHUCVU cv on cv.MaChucVu=nv.MaChucVu
join tbl_COSO cs on nv.MaCS = cs.MaCS
where @MaNV=bcc.MaNV
if(@SoCa is NULL)
begin 
print N'Không tìm thấy nhân viên có mã: '+@MaNV
end
if(@SoCa <= 0 )
begin
print N'Nhân viên đã nghỉ làm!'
end
else
begin
print N'Nhân viên còn làm. Thông tin của nhân viên là: '+ N', Họ tên: ' + @HoTen 
                        + N', Chức vụ: ' + @CV 
                        + N', Cơ sở: ' + @CS 
                        + N', Số ca làm việc: ' + cast(@SoCa as nvarchar);
end 
end 

exec sp_TrangThaiNhanVien @MaNV='NV01', @Nam=2024, @Thang=5
-----THỬ NGHIỆM LỆNH THÔNG BÁO NHÂN VIÊN ĐÃ NGHỈ LÀM
-----THAY ĐỔI SỐ CA LÀM CỦA NHÂN VIÊN CÓ MÃ SỐ 'NV05' =0
update tbl_CTBCC
set SoLan=0
from tbl_BANGCHAMCONG bcc join tbl_NHANVIEN nv on bcc.MaNV=nv.MaNV
join tbl_CTBCC ct on ct.MaBCC=bcc.MaBCC
where nv.MaNV='NV05'
----TRUY VẤN THÔNG TIN, SỐ CA LÀM CỦA NHÂN VIÊN CÓ MÃ SỐ 'NV05'
select nv.MaNV, nv.HoNV+''+TenNV as HoTen, sum(ct.SoLan) as SoCaLam
from tbl_BANGCHAMCONG bcc join tbl_NHANVIEN nv on bcc.MaNV=nv.MaNV
join tbl_CTBCC ct on ct.MaBCC=bcc.MaBCC
where  nv.MaNV='NV05'
group by  nv.MaNV, nv.HoNV,nv.TenNV
----KIỂM THỬ LỆNH NGHỈ LÀM
exec sp_TrangThaiNhanVien @MaNV='NV05', @Nam=2024, @Thang=5
-----KIỂM THỬ LỆNH KHÔNG TÌM THẤY MÃ NHÂN VIÊN
exec sp_TrangThaiNhanVien @MaNV='NV21', @Nam=2024, @Thang=5
drop proc sp_TrangThaiNhanVien

-----------------
/*
------------5. CẬP NHẬT CHỨC VỤ CHO NHÂN VIÊN QUA MÃ NHÂN VIÊN
create proc  sp_uChucVu @MaNV nchar(5), @MaCV nchar(5)
as
begin 
declare @dem int
select @dem= count(*) from tbl_NHANVIEN where @MaNV=MaNV
if(@dem<1 )
begin
print 'Nhan vien khong ton tai '
return;
end
update tbl_NHANVIEN
set MaChucVu=@MACV
where MaNV=@MaNV
/*update tbl_BANGCHAMCONG
set MaChucVu=@MACV
where MaNV=@MaNV*/
end 
-----KIỂM THỬ 1
exec sp_uChucVu @MaNV='NV10', @MaCV='CV01'
----KẾT QUẢ KIỂM THỬ BẢNG NHÂN VIÊN
select MaNV, MaChucVu
from tbl_NHANVIEN
where  MaNV='NV10'

/*----KẾT QUẢ KIỂM THỬ BẢNG BẢNG CHẤM CÔNG
select MaNV, MaChucVu
from tbl_BANGCHAMCONG
where  MaNV='NV10'*/

-----KIỂM THỬ 2
exec sp_uChucVu @MaNV='NV21', @MaCV='CV01'
----KẾT QUẢ KIỂM THỬ 2
select MaNV, MaChucVu
from tbl_BANGCHAMCONG
where  MaNV='NV10'
*/
 drop proc sp_uChucVu 
--------CẬP NHẬP LƯƠNG CỦA NHÂN VIÊN 

-------CỘNG 100000 CHO NHÂN VIÊN CÓ TGLV NHIỀU HƠN TGLV TIÊU CHUẨN


----TRỪ 100000 CHO MỖI NGÀY NHÂN VIÊN NGHỈ TỪ NGÀY NGHỈ VƯỢT QUÁ THỜI GIAN LÀM VIỆC TIÊU CHUẨN












