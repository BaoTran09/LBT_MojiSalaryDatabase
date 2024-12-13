create database SalaryMoji_4330 
use SalaryMoji_4330 


create table tbl_CHUCVU
(
MaChucVu nchar(5) primary key not null,
TenChucVu nvarchar(50) null,
LuongCB float  null,
HeSoLuong float  null,
TGLVTC int null,
)

create table tbl_COSO
(
MaCS nchar(5) primary key not null,
TenCS nvarchar(35)  null,
DiachiCS nvarchar(100) null,
)

create table tbl_NHANVIEN
(
MaNV nchar(5) primary key not null,
HoNV nvarchar(35)  null,
TenNV nvarchar(15)  null,
NgaySinh date  null,
DiaChi nvarchar(100) null,
Ngayvaolam date not null,
SDT nchar(10)  null,
Email nvarchar(30) null,
MaChucVu nchar(5) not null,
MaCS nchar(5) not null,
constraint FK_NHANVIEN_MACV foreign key (MaChucVu) references tbl_CHUCVU(MaChucVu),
constraint FK_NHANVIEN_MACS foreign key (MaCS) references tbl_COSO(MaCS),
)

create table tbl_CALAM
(
MaCL nchar(5) primary key not null,
DauCa time,
KetCa time, 
GhiChuCL text,
);

create table tbl_BANGCHAMCONG
(
MaBCC nchar(5) primary key not null,
MaNV nchar(5) not null,
Nam int,
Thang int,
HoNV nvarchar(25)  null,
TenNV nvarchar(15)  null,
constraint FK_BCC_MANV foreign key (MaNV) references tbl_NHANVIEN(MaNV),
)
create table tbl_CTBCC
(
MaBCC nchar(5) not null,
MaCL nchar(5) not null,
SoLan int null,
constraint FK_CTCaLam primary key (MaBCC, MaCL),
constraint FK_CTCaLam_MaBCC foreign key (MaBCC) references tbl_BANGCHAMCONG(MaBCC),
constraint FK_CTCaLam_MaCL foreign key (MaCL) references tbl_CALAM(MaCL)
)

create table tbl_BANGLUONG
(
MaLuong nchar(5) primary key not null,
MaNV nchar(5) not null,
HoNV nvarchar(35)  null,
TenNV nvarchar(15)  null,
Thang int,
Nam int,
constraint FK_BANGLUONG_MANV foreign key (MaNV) references tbl_NHANVIEN(MaNV),
)

create table tbl_KHOANNGOAILUONG
(
MaKNL nchar(5) primary key not null,
TenKNL nvarchar(50) null,
KhoanNL float null,
MoTa text null,
);

create table tbl_CTKNL
(
MaLuong nchar(5) not null,
MaKNL nchar(5)  not null,
HeSoNhan float null,
constraint PK_CTKNL primary key (MaLuong, MaKNL),
constraint FK_CTKNLM_MaLuong foreign key (MaLuong) references tbl_BANGLUONG(MaLuong),
constraint FK_CTKNLM_MaKNL foreign key (MaKNL) references tbl_KHOANNGOAILUONG(MaKNL)
);

INSERT INTO tbl_CHUCVU (MaChucVu, TenChucVu, luongCB ,HeSoLuong,TGLVTC ) VALUES
('OF01', 'Nhan Vien Marketing',30000, 1.1,24),
('CV01', 'Nhan Vien Ban Hang full time',23000 ,1.0,25),
('CV02', 'Quan Ly Cua Hang',23000, 1.5,26),
('CV03', 'Nhan Vien Kho',23000,1.0,22),
('CV04', 'Nhan Vien Thu Ngan',23000, 1.2,24),
('P01', 'Nhan Vien ban hang part time',17000, 1.0,24),
('KT01', 'Nhan Vien Ky Thuat',35000, 1.5,26);


select * from tbl_CHUCVU


INSERT INTO tbl_CALAM (MaCL, DauCa, KetCa, GhiChuCL) VALUES 
('PT01','8:00:00','12:00:00',NULL),
('PT02','12:00:00','15:00:00',NULL),
('PT03','15:00:00','18:00:00',NULL),
('PT04','18:00:00','22:00:00',NULL),
('VP01','8:30:00','16:30:00',NULL),
('FT01','8:00:00','18:00:00',NULL),
('FT02','13:00:00','22:00:00',NULL);

insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC01','FT01', 10 ),
('BC01','FT02', 15 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC02','FT01', 10 ),
('BC02','FT02', 14 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC03','FT01', 10 ),
('BC03','FT02', 12 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC04','FT01', 10 ),
('BC04','FT02', 13 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC05','FT01', 10 ),
('BC05','FT02', 14 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC06','FT01', 10 ),
('BC06','FT02', 16 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC07','FT01', 10 ),
('BC07','FT02', 14 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC08','FT01', 10 ),
('BC08','FT02', 12 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC09','VP01', 25 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC10','PT01', 5 ),
('BC10','PT02', 6 ),
('BC10','PT03', 8 ),
('BC10','PT04', 7 );

insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC11','FT01', 10 ),
('BC11','FT02', 15 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC12','FT01', 10 ),
('BC12','FT02', 14 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC13','FT01', 10 ),
('BC13','FT02', 12 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC14','FT01', 10 ),
('BC14','FT02', 13 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC15','FT01', 10 ),
('BC15','FT02', 14 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC16','FT01', 10 ),
('BC16','FT02', 16 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC17','FT01', 10 ),
('BC17','FT02', 14 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC18','FT01', 10 ),
('BC18','FT02', 12 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC19','VP01', 26 );
insert into tbl_CTBCC (MaBCC, MaCL, SoLan) values 
('BC20','PT01', 5 ),
('BC20','PT02', 6 ),
('BC20','PT03', 2 ),
('BC20','PT04', 7 );


INSERT INTO tbl_CHUCVU (MaChucVu, TenChucVu, luongCB ,HeSoLuong,TGLVTC ) VALUES
('OF01', 'Nhan Vien Marketing',30000, 1.1,24),
('CV01', 'Nhan Vien Ban Hang full time',23000 ,1.0,25),
('CV02', 'Quan Ly Cua Hang',23000, 1.5,26),
('CV03', 'Nhan Vien Kho',23000,1.0,22),
('CV04', 'Nhan Vien Thu Ngan',23000, 1.2,24),
('P01', 'Nhan Vien ban hang part time',17000, 1.0,24);


INSERT INTO tbl_COSO (MaCS, TenCS, DiachiCS) VALUES
('CS01', 'moji tran dai nghia', '60 Tran Dai Nghia, Hai Ba Trung, Ha Noi'),
('CS02', 'moji chua boc', '241 Chua Boc, Dong Da, Ha Noi'),
('CS03', 'moji xuan thuy', '157 Xuan Thuy, Cau Giay, Ha Noi'),
('CS04', 'moji ba trieu', '81 Ba Trieu, Hai Ba Trung, Ha Noi'),
('CS05', 'moji nguyen trai', '226 Nguyen Trai, Nam Tu Liem, Ha Noi'),
('CS06', 'moji nguyen dinh chieu', '459E Nguyen Dinh Chieu, Q.1, TP. Ho Chi Minh'),
('CS07', 'moji ho tung mau', '92 Ho Tung Mau, Q.1, TP. Ho Chi Minh'),
('CS08', 'moji phan xich long', '232 Phan Xich Long, Q. Phu Nhuan, TP. Ho Chi Minh'),
('CS09', 'moji bau cat', '87 Bau Cat,  Q. Tan Binh, TP. Ho Chi Minh'),
('CS10', 'moji su van hanh', '708 Su Van Hanh, Q. 10, TP. Ho Chi Minh');



INSERT INTO tbl_NHANVIEN (MaNV, HoNV, TenNV, NgaySinh, DiaChi, Ngayvaolam, SDT, email, MaChucVu, MaCS) VALUES
--TP HCM
('NV01', 'Le Bao', 'Tran', '1995-01-01', '33 Nguyen Dinh Chieu, P. Da Kao, Q.1, TP. Ho Chi Minh', '2023-01-10', '0901234567', 'tran.le@example.com', 'CV01', 'CS01'),
('NV02', 'Tran Thi', 'Thu Thao', '1992-02-02', '38 Xuan Thuy, P. Thao Dien, Q.2, TP. Ho Chi Minh', '2023-02-15', '0909876543', 'thao.tran@example.com', 'CV01',  'CS02'),
('NV03', 'Nguyen Minh', 'Khai', '1993-03-03', '47 Ba Trieu, P. Ben Nghe, Q.1, TP. Ho Chi Minh', '2022-03-20', '0912345678', 'khai.nguyen@example.com', 'CV01',  'CS03'),
('NV08', 'Le Thi', 'My', '1987-08-08', '14 Phan Xich Long, P. 1, Q. Phu Nhuan, TP. Ho Chi Minh', '2023-08-15', '0967890123', 'my.le@example.com', 'CV04', 'CS03'),
('NV04', 'Pham Thi', 'Hien', '1988-04-04', '45 Nguyen Trai, P. Ben Thanh, Q.1, TP. Ho Chi Minh', '2022-04-25', '0923456789', 'hien.pham@example.com', 'CV01',  'CS04'),

('NV05', 'Bui Thi', 'Ngan', '1985-05-05', '27 Ho Tung Mau, P. Ben Nghe, Q.1, TP. Ho Chi Minh', '2018-05-30', '0934567890', 'ngan.bui@example.com', 'CV02', 'CS05'),
('NV06', 'Truong Minh', 'Tuan', '1991-06-06', '29 Tran Dai Nghia, P. Tan Dinh, Q.1, TP. Ho Chi Minh', '2023-06-05', '0945678901', 'tuan.truong@example.com', 'CV02', 'CS01'),

('NV07', 'Nguyen Thi', 'Lan', '1995-07-07', '75 Phan Xich Long, P. 1, Q. Phu Nhuan, TP. Ho Chi Minh', '2020-07-10', '0956789012', 'lan.nguyen@example.com', 'CV03',  'CS02'),
('NV09', 'Vu Van', 'Tuan', '1994-09-09', '16 Bau Cat, P. 14, Q. Tan Binh, TP. Ho Chi Minh', '2019-09-20', '0978901234', 'tuan.vu@example.com', 'OF01',  'CS04'),
('NV10', 'Nguyen Van', 'An', '1990-10-10', '239 Su Van Hanh, P. 12, Q. 10, TP. Ho Chi Minh', '2023-10-25', '0989012345', 'an.nguyen@example.com', 'P01', 'CS05'),

-- HA NOI
('NV11', 'Hoang Thi', 'Nhi', '1992-11-11', '20 Tran Dai Nghia, Hai Ba Trung, Ha Noi', '2023-11-01', '0990123456', 'nhi.hoang@example.com', 'CV01',  'CS06'),
('NV12', 'Phan Minh', 'Hieu', '1989-12-12', '15 Xuan Thuy, Cau Giay, Ha Noi', '2019-12-05', '0911122233', 'hieu.phan@example.com', 'CV01',  'CS07'),
('NV13', 'Do Thi', 'Thuy', '1996-01-13', '7 Xuan Thuy, Cau Giay, Ha Noi', '2018-01-20', '0922233344', 'thuy.do@example.com', 'CV01',  'CS08'),
('NV14', 'Ngo Van', 'Khanh', '1994-02-14', '5 Ba Trieu, Hai Ba Trung, Ha Noi', '2018-02-25', '0933344455', 'khanh.ngo@example.com', 'CV01', 'CS09'),
('NV15', 'Le Van', 'Phuc', '1987-03-15', '8 Chua Boc, Dong Da, Ha Noi', '2018-03-30', '0944455566', 'phuc.le@example.com', 'CV02',  'CS10'),
('NV16', 'Bui Van', 'Luan', '1988-04-16', '10  Nguyen Trai, Nam Tu Liem, Ha Noi', '2019-04-05', '0955566677', 'luan.bui@example.com', 'CV02', 'CS06'),
('NV17', 'Trinh Van', 'Nhat', '1990-05-17', '12 Chua Boc, P. Trung Liet, Q. Dong Da, Ha Noi', '2020-05-20', '0966677788', 'nhat.trinh@example.com', 'CV03', 'CS07'),
('NV18', 'Ho Van', 'Tu', '1993-06-18', '84 Chua Boc, P. Trung Liet, Q. Dong Da, Ha Noi', '2020-06-25', '0977788899', 'tu.ho@example.com', 'CV04', 'CS08'),
('NV19', 'Vu Thi', 'Kim', '1985-07-19', '18 Ba Trieu, Hai Ba Trung, Ha Noi', '2021-07-30', '0988899000', 'kim.vu@example.com', 'OF01',  'CS09'),
('NV20', 'Nguyen Thi', 'Mai', '1991-08-20', '22 Nguyen Trai, Nam Tu Liem, Ha Noi', '2021-08-10', '0999900111', 'mai.nguyen@example.com', 'P01', 'CS10');
-------

INSERT INTO tbl_NHANVIEN (MaNV, HoNV, TenNV, NgaySinh, DiaChi, Ngayvaolam, SDT, email, MaChucVu, MaCS) VALUES
--TP HCM
('NV00', 'Tran Minh', 'Duc', '2000-03-05', 'So 5 Nguyen Hue, P. Da Kao, Q.1, TP. Ho Chi Minh', '2020-01-10', '0901222006', 'ductranminh@work.com', 'KT01', 'CS01');
select * from tbl_BANGCHAMCONG 
INSERT INTO tbl_BANGCHAMCONG (MaBCC,MaNV,Thang, Nam) VALUES
('BC01', 'NV01',05,2024),
('BC02', 'NV02', 05,2024),
('BC03', 'NV03', 05,2024),
('BC04', 'NV04',05,2024),
('BC05', 'NV05',05,2024),
('BC06', 'NV06',05,2024),
('BC07', 'NV07',05,2024),
('BC08', 'NV08', 05,2024),
('BC09', 'NV09',05,2024),
('BC10', 'NV10',05,2024),

('BC11', 'NV11',05,2024),
('BC12', 'NV12',05,2024),
('BC13', 'NV13',05,2024),
('BC14', 'NV14',05,2024),
('BC15', 'NV15',05,2024),
('BC16', 'NV16',05,2024),
('BC17', 'NV17',05,2024),
('BC18', 'NV18',05,2024),
('BC19', 'NV19',05,2024),
('BC20', 'NV20',05,2024);

/*INSERT INTO tbl_BANGLUONG (MaLuong,MaBCC ,MaNV, HoNV, TenNV,Thang,Nam) VALUES
('L01','BC01', 'NV01', 'Le Bao', 'Tran'),
('L02','BC02','NV01', 'Tran Thi', 'Thu Thao',05,2024),
('L03','BC03', 'NV03', 'Nguyen Minh', 'Khai',05,2024),
('L04','BC04', 'NV04', 'Pham Thi', 'Hien',05,2024),
('L05','BC05', 'NV05', 'Bui Thi', 'Ngan',05,2024),
('L06','BC06', 'NV06', 'Truong Minh', 'Tuan',05,2024),
('L07','BC07', 'NV07', 'Nguyen Thi', 'Lan',05,2024),
('L08','BC08', 'NV08', 'Le Thi', 'My',05,2024),
('L09','BC09', 'NV09', 'Vu Van', 'Tuan',05,2024),
('L10','BC10', 'NV10', 'Nguyen Van', 'An',05,2024),

('L11','BC11', 'NV11', 'Hoang Thi', 'Nhi',05,2024),
('L12','BC12', 'NV12', 'Phan Minh', 'Hieu',05,2024),
('L13','BC13', 'NV13', 'Do Thi', 'Thuy',05,2024),
('L14','BC14', 'NV14', 'Ngo Van', 'Khanh',05,2024),
('L15','BC15', 'NV15', 'Le Van', 'Phuc',05,2024),
('L16','BC16', 'NV16', 'Bui Van', 'Luan',05,2024),
('L17','BC17', 'NV17', 'Trinh Van', 'Nhat',05,2024),
('L18','BC18', 'NV18', 'Ho Van', 'Tu',05,2024),
('L19','BC19', 'NV19', 'Vu Thi', 'Kim',05,2024),
('L20','BC20', 'NV20', 'Nguyen Thi', 'Mai',05,2024);
*/

INSERT INTO tbl_BANGLUONG (MaLuong ,MaNV,Thang,Nam) VALUES
('L01','NV01', 05,2024),
('L02', 'NV02',05,2024),
('L03', 'NV03',05,2024),
('L04', 'NV04',05,2024),
('L05', 'NV05',05,2024),
('L06','NV06',05,2024),
('L07', 'NV07',05,2024),
('L08', 'NV08',05,2024),
('L09', 'NV09',05,2024),
('L10', 'NV10',05,2024),

('L11', 'NV11',05,2024),
('L12', 'NV12',05,2024),
('L13', 'NV13',05,2024),
('L14', 'NV14',05,2024),
('L15','NV15',05,2024),
('L16', 'NV16',05,2024),
('L17', 'NV17',05,2024),
('L18', 'NV18',05,2024),
('L19', 'NV19',05,2024),
('L20', 'NV20',05,2024);


INSERT INTO tbl_KHOANNGOAILUONG (MaKNL, TenKNL, KhoanNL,MoTa) VALUES
('BH01','Bao Hiem Xa Hoi',0.08, NULL),
('BH02','Bao Hiem That Nghiep',0.01, NULL),
('BH03','Bao Hiem Y Te',0.015,NULL),
('KT01','Ky luat di tre',50000,'Tru cho moi lan vi pham'),
('KT02','Ky luat nghi khong phep',50000,'Ap dung cho truong nhan vien co ca lam nhung nghi khong phep'),
('KT03','Ky luat sai dong phuc',20000,'Tru cho moi lan vi pham'),
('KT04','Ky luat sai don hang',20000,'Tru cho moi lan vi pham'),
('PC01', 'Phu Cap Cap Xang Xe', 100000,'Moi ca lam se duoc nhan phu cap xang xe 1 lan'),
('PC02', 'Phu Cap An Trua', 25000,'Ap dung cho NV lam ca "PT02", "P03","FT01","VP01"'),
('PC03', 'Phu Cap Suc Khoe 1', 50000, 'Khong ap dung cho nhan vien Part-time'),
('PC04', 'Phu Cap Suc Khoe 2', 30000,'Chi ap dung cho nhan vien Part-time '),
('T01','Khen thuong le tet',50000,NULL);

-----------------------------

insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L01', 'BH01', 1),  
('L01', 'BH02', 1),  
('L01','KT01', 2),
('L01', 'KT04', 2);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L02', 'BH01', 1),  
('L02', 'BH02', 1),  
('L02', 'KT04', 2),  
('L02', 'KT02', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L03', 'BH01', 1),  
('L03', 'BH02', 1),  
('L03', 'KT03', 1),  
('L03', 'KT01', 2);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L04', 'BH01', 1),  
('L04', 'BH02', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L05', 'BH01', 1),  
('L05', 'BH02', 1),  
('L05', 'KT01', 2),  
('L05', 'KT02', 2);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L06', 'BH01', 1),  
('L06', 'BH02', 1),  
('L06', 'KT03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L07', 'BH01', 1),  
('L07', 'BH02', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L08', 'BH01', 1),  
('L08', 'BH02', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L09', 'BH01', 1),  
('L09', 'BH02', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L10', 'KT01', 1);

insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L11', 'BH01', 1),  
('L11', 'BH02', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L12', 'BH01', 1),  
('L12', 'BH02', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L13', 'BH01', 1),  
('L13', 'BH02', 1),
('L13', 'KT01', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L14', 'BH01', 1),  
('L14', 'BH02', 1),
('L14', 'KT04', 2);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L15', 'BH01', 1),  
('L15', 'BH02', 1),
('L15', 'KT01', 1),
('L15', 'KT02', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L16', 'BH01', 1),  
('L16', 'BH02', 1),
('L16', 'KT03', 1),
('L16', 'KT04', 2);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L17', 'BH01', 1),  
('L17', 'BH02', 1),
('L17', 'KT01', 2),
('L17', 'KT02', 1),
('L17', 'KT04', 3);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L18', 'BH01', 1),  
('L18', 'BH02', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L19', 'BH01', 1),  
('L19', 'BH02', 1),
('L19', 'KT03', 2);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L20', 'BH01', 1),
('L20', 'KT01', 2);
--------------------------------------
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L01', 'PC01', 1),  
('L01', 'PC02', 25),
('L01', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L02', 'PC01', 1),  
('L02', 'PC02', 22),
('L02', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L03', 'PC01', 1),  
('L03', 'PC02', 26),
('L03', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L04', 'PC01', 1),  
('L04', 'PC02', 25),
('L04', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L05', 'PC01', 1),  
('L05', 'PC02', 27),
('L05', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L06', 'PC01', 1),  
('L06', 'PC02', 22),
('L06', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L07', 'PC01', 1),  
('L07', 'PC02', 23),
('L07', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L08', 'PC01', 1),  
('L08', 'PC02', 24),
('L08', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L09', 'PC01', 1),  
('L09', 'PC02', 26),
('L09', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L10', 'PC01', 1),  
('L10', 'PC02', 25),
('L10', 'PC04', 1);



insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L11', 'PC01', 1),  
('L11', 'PC02', 28),
('L11', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L12', 'PC01', 1),  
('L12', 'PC02', 22),
('L12', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L13', 'PC01', 1),  
('L13', 'PC02', 20),
('L13', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L14', 'PC01', 1),  
('L14', 'PC02', 23),
('L14', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L15', 'PC01', 1),  
('L15', 'PC02', 27),
('L15', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L16', 'PC01', 1),  
('L16', 'PC02', 25),
('L16', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L17', 'PC01', 1),  
('L17', 'PC02', 24),
('L17', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L18', 'PC01', 1),  
('L18', 'PC02', 25),
('L18', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L19', 'PC01', 1),  
('L19', 'PC02', 24),
('L19', 'PC03', 1);
insert into tbl_CTKNL(MaLuong,MaKNL,HeSoNhan) values
('L20', 'PC01', 1),  
('L20', 'PC02', 20),
('L20', 'PC04', 1);

------CHỈ MỤC INDEX
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



------SYNONYM 
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



------KHUNG NHÌN VIEW 
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

------HÀM FUNCTION 
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

--KIỂM THỬ 
select dbo.f_TongLuong('NV01',05,2024) as TongLuong




------THỦ TỤC STORE PROCEDURE 
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


------TRIGGER 



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

--KIỂM THỬ 
select * from tbl_NHANVIEN where MaCS='CS01'



------GIAO TÁC TRANSACTION 
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


------USER 
---------------1. Thiết lập các nhóm người dùng hệ thống 
create role QuanLyCuaHang
create role ThuNgan 
create role NhanVien
create role NhanVienKyThuat

--CẤP QUYỀN CHO NHÂN VIÊN: SELECT CHO CÁC BẢNG: 
--BẢNG CHẤM CÔNG VÀ BẢNG NHÂN VIÊN
grant select on tbl_BANGCHAMCONG to NhanVien
grant select on tbl_NHANVIEN to NhanVien

--CẤP QUYỀN CHO NHÂN VIÊN KỸ THUẬT: TẤT CẢ CÁC QUYỀN 
--CÓ THỂ PHÂN QUYỀN CHO NGƯỜI KHÁC
grant all to NhanVienKyThuat with grant option 


--CẤP QUYỀN CHO QUẢN LÝ CỬA HÀNG: INSERT, UPDATE, DELETE
--CHO CÁC BẢNG BẢNG CHẤM CÔNG, BẢNG NHÂN VIÊN, BẢNG CHỨC VỤ, BẢNG CA LÀM, BẢNG CƠ SỞ.
grant select, insert, update, delete on tbl_NHANVIEN to QuanLyCuaHang
grant select, insert, update, delete on tbl_BANGCHAMCONG to QuanLyCuaHang
grant select, insert, update, delete on tbl_CHUCVU to QuanLyCuaHang
grant select, insert, update, delete on tbl_CALAM to QuanLyCuaHang
grant select, insert, update, delete on tbl_COSO to QuanLyCuaHang

--CẤP QUYỀN CHO QUẢN LÝ CỬA HÀNG: INSERT, UPDATE, DELETE
--CHO CÁC BẢNG BẢNG LƯƠNG, BẢNG KHOẢN NGOÀI LƯƠNG.
grant select, insert, update, delete on tbl_BANGLUONG to ThuNgan 
grant select, insert, update, delete on tbl_KHOANNGOAILUONG to ThuNgan 



--TẠO TÀI KHOẢN ĐĂNG NHẬP 

EXEC sp_addlogin 'LeBaoTran', '11111', 'SalaryMoji_4330'
EXEC sp_adduser 'LeBaoTran', 'LeBaoTran'

EXEC sp_addlogin 'TruongMinhTuan', '11111', 'SalaryMoji_4330'
EXEC sp_adduser 'TruongMinhTuan', 'TruongMinhTuan'

EXEC sp_addlogin 'HoVanTu', '11111', 'SalaryMoji_4330'
EXEC sp_adduser 'HoVanTu', 'HoVanTu'

EXEC sp_addlogin 'TranMinhDuc', 'admin', 'SalaryMoji_4330'
EXEC sp_adduser 'TranMinhDuc', 'TranMinhDuc'

-- THÊM USER VÀO CÁC ROLE 
-- THÊM NGƯỜI DÙNG LÊ BẢO TRÂN VÀO NHÓM NHÂN VIÊN  
sp_addrolemember 'NhanVien', 'LeBaoTran'

-- THÊM NGƯỜI DÙNG TRƯƠNG MINH TUẤN VÀO NHÓM QUẢN LÝ CỬA HÀNG
sp_addrolemember 'QuanLyCuaHang', 'TruongMinhTuan'

-- THÊM NGƯỜI DÙNG HỒ VĂN TÚ VÀO NHÓM THU NGÂN 
sp_addrolemember 'ThuNgan', 'HoVanTu'

-- THÊM NGƯỜI DÙNG TRẦN MINH ĐỨC VÀO NHÓM NHÂN VIÊN KỸ THUẬT   
sp_addrolemember 'NhanVienKyThuat', 'TranMinhDuc'

