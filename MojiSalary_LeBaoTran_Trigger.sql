use testtrigger_moji
use testnewdata
--1. TỰ ĐỘNG CẬP NHẬT THÔNG TIN NHÂN VIÊN Ở BẢNG CHẤM CÔNG/BẢNG LƯƠNG 
--KHI THAY ĐỔI THÔNG TIN NHÂN VIÊN Ở BẢNG NHÂN VIÊN.
/*create trigger tg_uTTNV
on tbl_NHANVIEN
for update 
as begin
    -- Cập nhật thông tin họ và tên trong bảng BANGCHAMCONG nếu có thay đổi
select HoNV, TenNV from inserted i
update tbl_BANGCHAMCONG 
set HoNV = i.HoNV,
        TenNV = i.TenNV
from  tbl_BANGCHAMCONG bcc 
join inserted i on bcc.MaNV=i.MaNV
join deleted d on bcc.MaNV=d.MaNV
where i.HoNV<>d.HoNV or i.TenNV<>d.TenNV
    -- Cập nhật thông tin họ và tên trong bảng BANGLUONG nếu có thay đổi
update tbl_BANGLUONG 
set HoNV = i.HoNV,
        TenNV = i.TenNV
from  tbl_BANGLUONG bl 
join inserted i on bl.MaNV=i.MaNV
join deleted d on bl.MaNV=d.MaNV
where i.HoNV<>d.HoNV or i.TenNV<>d.TenNV
end

update tbl_NHANVIEN
set HoNV='Le Bao'
where MaNV='NV01'

select MaNV, HoNV, TenNV from tbl_BANGCHAMCONG  where MaNV='NV01'
select MaNV, HoNV, TenNV from tbl_BANGLUONG  where MaNV='NV01'*/

--2. CƠ SỞ TỐI ĐA 3 NHÂN VIÊN FULL-TIME VÀ 2 NV PART - TIME, 1 QUẢN LÝ CỬA HÀNG
--TẠO TRIGGER GIỚI HẠN KHI THÊM NHÂN VIÊN MỚI    
create trigger tg_iThemNV
on tbl_NHANVIEN
for insert 
as
begin
declare @dem1 int, @dem2 int, @dem3 int
select MaNV, HoNV, TenNV, NgaySinh, DiaChi, Ngayvaolam, SDT, Email, MaChucVu, MaCS 
							from inserted 
select @dem1=count(nv.MaNV) from tbl_NHANVIEN nv join inserted i 
						on nv.MaCS=i.MaCS where nv.MaChucVu='CV01' 
select @dem2=count(nv.MaNV) from tbl_NHANVIEN nv join inserted i 
						on nv.MaCS=i.MaCS where nv.MaChucVu='CV06'
select @dem3=count(nv.MaNV) from tbl_NHANVIEN nv join inserted i 
						on nv.MaCS=i.MaCS where nv.MaChucVu='CV02'
if(@dem1>3 or @dem2>2 or @dem3>1)
begin
print N'Cơ sở đã đủ nhân viên'
rollback
end
end


select * from tbl_NHANVIEN where MaCS='CS01'

INSERT INTO tbl_NHANVIEN (MaNV, HoNV, TenNV, NgaySinh, DiaChi, Ngayvaolam, SDT, email, MaChucVu, MaPB, MaCS) VALUES
('NV04', 'Le Thi', 'My', '1987-08-08', '14 Phan Xich Long, P. 1, Q. Phu Nhuan, TP. Ho Chi Minh',
'2023-08-15', '0967890123', 'my.le@example.com', 'CV01', 'PB01', 'CS01'),
/*
INSERT INTO tbl_NHANVIEN (MaNV, HoNV, TenNV, NgaySinh, DiaChi, Ngayvaolam, SDT, email, MaChucVu, MaPB, MaCS) VALUES
--TP HCM
('NV02', 'Tran Thi', 'Thu Thao', '1992-02-02', '38 Xuan Thuy, P. Thao Dien, Q.2, TP. Ho Chi Minh', '2023-02-15', '0909876543', 'thao.tran@example.com', 'CV01', 'PB01', 'CS01'),
INSERT INTO tbl_NHANVIEN (MaNV, HoNV, TenNV, NgaySinh, DiaChi, Ngayvaolam, SDT, email, MaChucVu, MaPB, MaCS) VALUES
('NV03', 'Nguyen Minh', 'Khai', '1993-03-03', '47 Ba Trieu, P. Ben Nghe, Q.1, TP. Ho Chi Minh', '2022-03-20', '0912345678', 'khai.nguyen@example.com', 'CV01', 'PB01', 'CS01'),*/
drop trigger tg_iThemNV


CREATE TRIGGER trg_UpdateSalaryOnBCCInsert
ON tbl_BANGCHAMCONG
AFTER INSERT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN 
        -- Tính tổng số giờ làm
        DECLARE @TotalHours INT;
        SELECT @TotalHours = SUM(DATEDIFF(HOUR, c.DauCa, c.KetCa) * ct.SoLan)
        FROM tbl_CTBCC ct
        INNER JOIN tbl_CALAM c ON ct.MaCL = c.MaCL
        WHERE ct.MaBCC IN (SELECT MaBCC FROM inserted);
        -- Lấy thông tin nhân viên và chấm công
        DECLARE @MaNV nchar(5), @LuongCB FLOAT, @HeSoLuong FLOAT, @Thang INT, @Nam INT;
        SELECT TOP 1 
            @MaNV = bcc.MaNV, 
            @LuongCB = cv.LuongCB, 
            @HeSoLuong = cv.HeSoLuong, 
            @Thang = bcc.Thang, 
            @Nam = bcc.Nam
        FROM tbl_BANGCHAMCONG bcc
        INNER JOIN tbl_NHANVIEN nv ON bcc.MaNV = nv.MaNV
        INNER JOIN tbl_CHUCVU cv ON nv.MaChucVu = cv.MaChucVu
        WHERE bcc.MaBCC IN (SELECT MaBCC FROM inserted);
        -- Tính lương
        DECLARE @TongLuong FLOAT;
        SET @TongLuong = @LuongCB * @HeSoLuong * (@TotalHours / 160.0);
        -- Thêm vào bảng lương
        INSERT INTO tbl_BANGLUONG (MaLuong, MaNV, Thang, Nam)
        VALUES (
            CONCAT('L', @MaNV, @Thang), 
            @MaNV, 
            @Thang, 
            @Nam
        );
        COMMIT TRANSACTION;
    BEGIN 
        ROLLBACK TRANSACTION;
    END;
END;
SELECT * FROM tbl_NHANVIEN WHERE MaCS = 'CS01'

DROP TRIGGER trg_iThemNV_BCC_BL
--1. TỰ ĐỘNG TẠO BẢNG LUƠNG VÀ BẢNG CHẤM CÔNG KHI THÊM MỚI 1 NHÂN VIÊN
CREATE TRIGGER trg_iThemNV_BCC_BL
ON tbl_NHANVIEN
AFTER INSERT
AS
BEGIN 
BEGIN TRY
BEGIN TRANSACTION;
-- Khai báo biến 
DECLARE @Thang INT, @Nam INT;
SET @Thang = MONTH(GETDATE());
SET @Nam = YEAR(GETDATE());
-- Tạo mã bảng chấm công (MaBCC) dựa trên số lượng hiện tại
DECLARE @SoLuongBCC INT, @SoLuongLuong INT;
SET @SoLuongBCC = (SELECT COUNT(*) FROM tbl_BANGCHAMCONG);
SET @SoLuongLuong = (SELECT COUNT(*) FROM tbl_BANGLUONG);
-- Thêm bản ghi vào bảng chấm công
INSERT INTO tbl_BANGCHAMCONG (MaBCC, MaNV, Nam, Thang, HoNV, TenNV)
SELECT 
  'BC' + RIGHT('0' + CAST(@SoLuongBCC + ROW_NUMBER() OVER (ORDER BY MaNV) AS NVARCHAR), 3),
   MaNV, @Nam, @Thang, HoNV, TenNV
FROM 
   inserted;
PRINT 'Da them du lieu vao bang cham cong.';
-- Thêm bản ghi vào bảng lương
INSERT INTO tbl_BANGLUONG (MaLuong, MaNV, HoNV, TenNV, Thang, Nam)
SELECT 
   'L' + RIGHT('0' + CAST(@SoLuongLuong + ROW_NUMBER() OVER (ORDER BY MaNV) AS NVARCHAR), 3),
   MaNV, HoNV, TenNV, @Thang, @Nam
FROM 
   inserted;
PRINT 'Da them du lieu vao bang luong.';
-- Xác nhận giao dịch
COMMIT TRANSACTION;
PRINT 'Them du lieu thanh cong!';
END TRY
BEGIN CATCH
-- Rollback nếu có lỗi
ROLLBACK TRANSACTION;
PRINT 'Loi! Khong the them du lieu!';
PRINT ERROR_MESSAGE();
END CATCH
END;

--KIỂM THỬ 
INSERT INTO tbl_NHANVIEN (MaNV, HoNV, TenNV, NgaySinh, DiaChi, Ngayvaolam, SDT, email, MaChucVu, MaCS) 
VALUES 
('NV24', 'Trieu Ngoc', 'Tu', '2001-05-07', '75 Phan Xich Long, Q. Phu Nhuan, TP. Ho Chi Minh', '2023-11-26', '0902123456', 'tu.trieu@example.com', 'CV02', 'CS01');

--KIỂM THỬ
SELECT * FROM tbl_NHANVIEN WHERE MaNV = 'NV24';

--KIỂM TRA tbl_BANGCHAMCONG 
SELECT * FROM tbl_BANGCHAMCONG WHERE MaNV = 'NV24';

--KIỂM TRA tbl_BANGLUONG 
SELECT * FROM tbl_BANGLUONG WHERE MaNV = 'NV24';








/*MỖI CHỨC VỤ CÓ MÃ CA LÀM NHẤT ĐỊNH. NHÂN VIÊN THUỘC BỘ PHẬN VĂN PHÒNG NHƯ 'NHÂN VIÊN MARKETING',.. CÓ MÃ CA LÀM 
LÀ 'VP...', BỘ PHẬN BÁN HÀNG CHÍNH THỨC NHƯ 'NHÂN VIÊN THU NGÂN, NHÂN VIÊN BÁN HÀNG FULL-TIME,...' SẼ CÓ MÃ CA LÀM LÀ
'FT...'. NHÂN VIÊN PART-TIME CÓ MÃ CA LÀM BẮT ĐẦU TỪ 'PT...'. TẠO TRIGGER KHI NHẬP BẢNG tbl_CTBCC*/

create trigger tg_iCaLam_CTBCC
on tbl_CTBCC
for insert, update
as
begin
    -- khai báo biến
    declare @macl nchar(5), @macv nchar(5), @mabcc nchar(5), @macl1 nchar(5), @mabcc1 nchar(5);
select @macl, @mabcc from inserted
select @macl1,@mabcc1 from deleted 
 begin tran -- bắt đầu giao dịch
    -- kiểm tra các dòng không hợp lệ
    if exists (
        select 1
        from inserted i
        join tbl_BANGCHAMCONG bcc on i.MaBCC = bcc.MaBCC
        join tbl_NHANVIEN nv on bcc.MaNV = nv.MaNV
        where 
            (nv.MaChucVu like 'OF%' and i.macl not like 'VP%') or
            (nv.MaChucVu like 'CV%' and i.macl not like 'FT%') or
            (nv.MaChucVu like 'P%' and i.macl not like 'PT%'))
    begin
        print 'Mã ca không phù hợp với chức vụ của nhân viên.';
        rollback tran; -- hủy giao dịch
        return;
    end
    commit tran; -- xác nhận giao dịch nếu không có lỗi
end;

	drop trigger tg_iCaLam
	delete from tbl_CTBCC where MaBCC='BC05'
	insert into tbl_CTBCC (MaBCC,MaCL,SoLan)values 
	('BC05','VP01', 10 );
	select * from tbl_CTBCC where MaBCC='BC05'


