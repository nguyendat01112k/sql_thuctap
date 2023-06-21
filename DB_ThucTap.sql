create database ThucTap;

CREATE TABLE Khoa (
    makhoa CHAR(10) PRIMARY KEY,
    tenkhoa CHAR(30),
    dienthoai CHAR(10)
);

CREATE TABLE GiangVien (
    magv INT PRIMARY KEY,
    hotengv CHAR(30),
    luong DECIMAL(5,2),
    makhoa CHAR(10),
    FOREIGN KEY (makhoa) REFERENCES Khoa(makhoa)
);

CREATE TABLE SinhVien (
    masv INT PRIMARY KEY,
    hotensv CHAR(30),
    makhoa CHAR(10),
    namsinh INT,
    quequan CHAR(30),
    FOREIGN KEY (makhoa) REFERENCES Khoa(makhoa)
);

CREATE TABLE DeTai (
    madt CHAR(10) PRIMARY KEY,
    tendt CHAR(30),
    kinhphi INT,
    NoiThucTap CHAR(30)
);

CREATE TABLE HuongDan (
    masv INT,
    madt CHAR(10),
    magv INT,
    ketqua DECIMAL(5,2),
    PRIMARY KEY (masv, madt, magv),
    FOREIGN KEY (masv) REFERENCES SinhVien(masv),
    FOREIGN KEY (madt) REFERENCES DeTai(madt),
    FOREIGN KEY (magv) REFERENCES GiangVien(magv)
);

INSERT INTO Khoa (makhoa, tenkhoa, dienthoai) VALUES
('Geo','Dia ly va QLTN',3855413),
('Math','Toan',3855411),
('Bio','Cong nghe Sinh hoc',3855412);


-- Thêm dữ liệu vào bảng Giảng Viên :
 INSERT INTO GiangVien (magv, hotengv, luong, makhoa) VALUES
(11,'Thanh Xuan',700,'Geo'),
(12,'Thu Minh',500,'Math'),
(13,'Chu Tuan',650,'Geo'),
(14,'Le Thi Lan',500,'Bio'),
(15,'Tran Xoay',900,'Math');


-- Thêm dữ liệu vào bảng SInh Viên :
INSERT INTO SinhVien (masv, hotensv, makhoa, namsinh, quequan) VALUES
(1,'Le Van Sao','Bio',1990,'Nghe An'),
(2,'Nguyen Thi My','Geo',1990,'Thanh Hoa'),
(3,'Bui Xuan Duc','Math',1992,'Ha Noi'),
(4,'Nguyen Van Tung','Bio',null,'Ha Tinh'),
(5,'Le Khanh Linh','Bio',1989,'Ha Nam'),
(6,'Tran Khac Trong','Geo',1991,'Thanh Hoa'),
(7,'Le Thi Van','Math',null,'null'),
(8,'Hoang Van Duc','Bio',1992,'Nghe An');

-- Thêm dữ liệu vào bảng Đề Tài :
INSERT INTO DeTai (madt, tendt, kinhphi, NoiThucTap) VALUES
('Dt01','GIS',100,'Nghe An'),
('Dt02','ARC GIS',500,'Nam Dinh'),
('Dt03','Spatial DB',100, 'Ha Tinh'),
('Dt04','MAP',300,'Quang Binh' );

-- Thêm dữ liệu vào bảng Hướng Dẫn  :
INSERT INTO HuongDan (masv, madt, magv, ketqua) VALUES
(1,'Dt01',13,8),
(2,'Dt03',14,0),
(3,'Dt03',12,10),
(5,'Dt04',14,7),
(6,'Dt01',13,Null),
(7,'Dt04',11,10),
(8,'Dt03',15,6);

-- Sử dụng lệnh truy vấn SQL lấy ra mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập .
SELECT madt, tendt
FROM DeTai
WHERE madt IN (
    SELECT madt
    FROM HuongDan
    GROUP BY madt
    HAVING COUNT(DISTINCT masv) > 2
);

Select h.madt, count (h.madt) as "so sv"
from huongdan h join sinhvien s
on h.masv = s.masv
group by h.madt
HAVING COUNT(h.madt) >= 2;
-- Sử dụng câu lệnh truy vấn SQL lấy ra mã số, tên đề tài của đề tài có kinh phí cao nhất .
SELECT madt, tendt
FROM DeTai
WHERE kinhphi = (
    SELECT MAX(kinhphi)
    FROM DeTai
);
SELECT madt, tendt, kinhphi
FROM DeTai
ORDER BY kinhphi DESC
LIMIT 1;
	
SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SET sql_mode = 'IGNORE_SPACE';
SET sql_mode = 'ANSI';
-- Sử dụng câu lệnh SQL xuất ra Tên khoa, Số lượng sinh viên của mỗi khoa .
select s.makhoa, k.tenkhoa ,count (s.makhoa) as "so luong sinh vien"
from khoa k join sinhvien s
on k.makhoa = s.makhoa
group by s.makhoa;





