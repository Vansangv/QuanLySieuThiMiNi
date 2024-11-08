package quanlysieuthi.demo.Etity;

import jakarta.persistence.*;
import lombok.*;


import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;


@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "hanghoa")
public class HangHoa {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;


    @Column(name = "Ma")
    private String ma;  // Mã hàng hóa

    @Column(name = "Ten")
    private String ten;  // Tên hàng hóa

    @Column(name = "Gia")
    private double gia;  // Giá hàng hóa

    @Column(name = "SL")
    private int soLuong;  // Số lượng

    @Column(name = "Donvi", length = 50)
    private String donVi;  // Đơn vị tính

    @Column(name = "Ngaynhap")
    private LocalDate ngayNhap;  // Ngày nhập

    @Column(name = "HSD")
    private LocalDate hanSuDung;  // Hạn sử dụng

    @Column(name = "TimeNgaynhap")
    private LocalTime thoiGianNgayNhap;  // Thời gian nhập hàng

    @Column(name = "TimeHSD")
    private LocalTime thoiGianHSD;  // Thời gian hạn sử dụng

    @Column(name = "TongThanhPhan")
    private String tongThanhPhan;

}