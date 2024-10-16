package quanlysieuthi.demo.Etity;

import jakarta.persistence.*;
import lombok.*;

import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "khachhang")
public class KhachHang {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "MaKhachHang")
    private String ma;

    @Column(name = "TenKhachHang")
    private String ten;

    @Column(name = "SoDienThoai")
    private String sdt;

    @Column(name = "DiemTichLuy")
    private Integer diemTL;

    @Column(name = "NgayTao")
    private Date ngayTao;

    @Column(name = "NgaySua")
    private Date ngaySua;
}
