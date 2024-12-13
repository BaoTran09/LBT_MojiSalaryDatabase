

use testnewdata
------------FUNCTION
use SalaryMoji_4330

--1. TÍNH SỐ GIỜ LÀM VIỆC CỦA NHÂN VIÊN
create function f_GioLamViec(@MaNV nchar(5), @Thang int, @Nam int)
returns float
as
begin
declare @Gio int 
set  @Gio=(select sum(datediff(hour,cl.DauCa,cl.KetCa )*ct.SoLan) 
from tbl_CaLam cl join tbl_CTBCC ct on cl.MaCL=ct.MaCL
join tbl_BANGCHAMCONG bcc on ct.MaBCC=bcc.MaBCC
where @MaNV=MaNV and @Thang=bcc.Thang and @Nam=bcc.Nam)
return @Gio
end 

--KIỂM THỬ 
select dbo.f_GioLamViec('NV01',05,2024) as TongTGLV

drop  function f_GioLamViec

--2. TÍNH TỔNG LƯƠNG CỦA NHÂN VIÊN KỲ LƯƠNG THÁNG... NĂM...
create function f_TongLuong(@MaNV nchar(5), @Thang int , @Nam int)
returns float
as
begin
declare @TongLuong float =0,
@BaoHiem float =0,
@KyLuat float = 0,
@PhuCap float = 0,
@Thuong float = 0,
@Gio int = 0,
@LuongBH float = 0,
@Luong1 float = 0
set @Gio=dbo.f_GioLamViec(@MaNV, @Thang, @Nam);
select @Luong1=isnull(((cv.HeSoLuong*cv.LuongCB)*@Gio),0)
from tbl_BANGLUONG bl 
join tbl_NHANVIEN nv on nv.MaNV=bl.MaNV
join tbl_CHUCVU cv on nv.MaChucVu=cv.MaChucVu
where @MaNV=bl.MaNV and @Thang=bl.Thang and @Nam=bl.Nam
select @PhuCap = isnull(sum (KhoanNL*HeSoNhan),0)
from tbl_KHOANNGOAILUONG knl 
join tbl_CTKNL ctnl on knl.MaKNL=ctnl.MaKNL
join tbl_BANGLUONG bl on ctnl.MaLuong=bl.MaLuong
where @MaNV=bl.MaNV and @Thang=bl.Thang and @Nam=bl.Nam and ctnl.MaKNL like 'PC%'
select @KyLuat = isnull(sum (KhoanNL*HeSoNhan),0)
from tbl_KHOANNGOAILUONG knl 
join tbl_CTKNL ctnl on knl.MaKNL=ctnl.MaKNL
join tbl_BANGLUONG bl on ctnl.MaLuong=bl.MaLuong
where @MaNV=bl.MaNV and @Thang=bl.Thang and @Nam=bl.Nam and ctnl.MaKNL like 'KT%'
select @Thuong = isnull(sum (KhoanNL*HeSoNhan),0)
from tbl_KHOANNGOAILUONG knl 
join tbl_CTKNL ctnl on knl.MaKNL=ctnl.MaKNL
join tbl_BANGLUONG bl on ctnl.MaLuong=bl.MaLuong
where @MaNV=bl.MaNV and @Thang=bl.Thang and @Nam=bl.Nam and ctnl.MaKNL like 'T%'
select @LuongBH = isnull((cv.HeSoLuong*cv.LuongCB*@Gio) + (knl.KhoanNL*ctnl.HeSoNhan),0)
from  tbl_KHOANNGOAILUONG knl join tbl_CTKNL ctnl on knl.MaKNL=ctnl.MaKNL
join tbl_BANGLUONG bl on ctnl.MaLuong=bl.MaLuong
join tbl_NHANVIEN nv on nv.MaNV=bl.MaNV
join tbl_CHUCVU cv on nv.MaChucVu=cv.MaChucVu
where @MaNV=nv.MaNV and @Thang=bl.Thang and @Nam=bl.Nam and ctnl.MaKNL like 'PC%' 
and ctnl.MaKNL not in('PC01','PC02')
select @BaoHiem =isnull(sum( @LuongBH*ctnl.HeSoNhan*knl.KhoanNL),0)
from tbl_KHOANNGOAILUONG knl join tbl_CTKNL ctnl on knl.MaKNL=ctnl.MaKNL
join tbl_BANGLUONG bl on ctnl.MaLuong=bl.MaLuong
where @MaNV=bl.MaNV and @Thang=bl.Thang and @Nam=bl.Nam and ctnl.MaKNL like 'BH%'
set  @TongLuong = @Luong1- @BaoHiem -@KyLuat+ @PhuCap +@Thuong
return @TongLuong;
end


select dbo.f_TongLuong('NV01',05,2024) as TongLuong
drop function f_TongLuong


/*
--------
create function f_PhuCap(@MaNV nchar(5), @Thang int , @Nam int)
returns float
as
begin
declare @PhuCap float
select @PhuCap = sum (KhoanNL*HeSoNhan) 
from tbl_KHOANNGOAILUONG knl 
join tbl_CTKNL ctnl on knl.MaKNL=ctnl.MaKNL
join tbl_BANGLUONG bl on ctnl.MaLuong=bl.MaLuong
where @MaNV=bl.MaNV and @Thang=bl.Thang and @Nam=bl.Nam and ctnl.MaKNL like 'PC%'
return @PhuCap
end 
select dbo.f_PhuCap('NV01',05,2024) as PhuCap
select * from tbl_CTKNL where MaLuong='L01'
--------

create function f_KyLuat(@MaNV nchar(5), @Thang int , @Nam int)
returns float
as
begin
declare @KyLuat float
select @KyLuat = sum (KhoanNL*HeSoNhan)
from tbl_KHOANNGOAILUONG knl 
join tbl_CTKNL ctnl on knl.MaKNL=ctnl.MaKNL
join tbl_BANGLUONG bl on ctnl.MaLuong=bl.MaLuong
where @MaNV=bl.MaNV and @Thang=bl.Thang and @Nam=bl.Nam and ctnl.MaKNL like 'KT%'
return @KyLuat
end 
select dbo.f_KyLuat('NV01',05,2024) as KyLuat
---------
create function f_Thuong(@MaNV nchar(5), @Thang int , @Nam int)
returns float
as
begin
declare @Thuong float
select @Thuong = sum (KhoanNL*HeSoNhan)
from tbl_KHOANNGOAILUONG knl 
join tbl_CTKNL ctnl on knl.MaKNL=ctnl.MaKNL
join tbl_BANGLUONG bl on ctnl.MaLuong=bl.MaLuong
where @MaNV=bl.MaNV and @Thang=bl.Thang and @Nam=bl.Nam and ctnl.MaKNL like 'T%'
return @Thuong
end 
select dbo.f_Thuong('NV01',05,2024) as Thuong

------
create function f_LuongBH(@MaNV nchar(5), @Thang int , @Nam int)
returns float
as
begin
declare @LuongBH float, @Gio int 
set @Gio=dbo.f_GioLamViec(@MaNV, @Thang, @Nam);
select @LuongBH =(cv.HeSoLuong*cv.LuongCB*@Gio) + (knl.KhoanNL*ctnl.HeSoNhan)
from  tbl_KHOANNGOAILUONG knl join tbl_CTKNL ctnl on knl.MaKNL=ctnl.MaKNL
join tbl_BANGLUONG bl on ctnl.MaLuong=bl.MaLuong
join tbl_NHANVIEN nv on nv.MaNV=bl.MaNV
join tbl_CHUCVU cv on nv.MaChucVu=cv.MaChucVu
where @MaNV=nv.MaNV and @Thang=bl.Thang and @Nam=bl.Nam and ctnl.MaKNL like 'PC%' 
and ctnl.MaKNL not in('PC01','PC02')
return @LuongBH
end
select dbo.f_LuongBH('NV01',5,2024) as LuongBH
drop function f_LuongBH

create function f_BaoHiem(@MaNV nchar(5), @Thang int , @Nam int)
returns float
as
begin
declare @LuongBH float, @BaoHiem float 
set @LuongBH=dbo.f_LuongBH(@MaNV, @Thang, @Nam);
select @BaoHiem =sum( @LuongBH*ctnl.HeSoNhan*knl.KhoanNL)
from tbl_KHOANNGOAILUONG knl join tbl_CTKNL ctnl on knl.MaKNL=ctnl.MaKNL
join tbl_BANGLUONG bl on ctnl.MaLuong=bl.MaLuong
where @MaNV=bl.MaNV and @Thang=bl.Thang and @Nam=bl.Nam and ctnl.MaKNL like 'BH%'
return  isnull(@BaoHiem, 0)
end

select dbo.f_BaoHiem('NV01',05,2024) as BaoHiem
drop function f_BaoHiem
select * from tbl_CTKNL where MaLuong='L01'
select * from tbl_KHOANNGOAILUONG
----------------
create function f_TongLuong1(@MaNV nchar(5), @Thang int , @Nam int)
returns float
as
begin
declare  @BaoHiem float,@KyLuat float, @PhuCap float, @Thuong float, @Gio float, @TongLuong float
set @BaoHiem=dbo.f_BaoHiem(@MaNV, @Thang, @Nam)
set @KyLuat=dbo.f_KyLuat(@MaNV, @Thang, @Nam)
set @Gio = dbo.f_GioLamViec(@MaNV, @Thang, @Nam)
set @PhuCap=dbo.f_PhuCap(@MaNV, @Thang, @Nam)
set @Thuong=dbo.f_Thuong(@MaNV, @Thang, @Nam)
select @TongLuong = ((cv.HeSoLuong*cv.LuongCB)*@Gio) - @BaoHiem -@KyLuat+ @PhuCap 
from tbl_BANGLUONG bl
join tbl_NHANVIEN nv on nv.MaNV=bl.MaNV
join tbl_CHUCVU cv on nv.MaChucVu=cv.MaChucVu
where @MaNV=nv.MaNV and @Thang=bl.Thang and @Nam=bl.Nam
return @TongLuong 
end 
select dbo.f_TongLuong1('NV01',05,2024) as TongLuong1
drop function f_TongLuong1

*/
