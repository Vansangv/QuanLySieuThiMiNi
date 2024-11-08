package quanlysieuthi.demo.Etity;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.Date;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Builder
@Table(name = "ChiTietHoaDon")
public class ChiTietHoaDon {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "MaHoaDon")
    private String maHoaDon; // Mã hóa đơn

    @ManyToOne
    @JoinColumn(name = "KhachHang_id")
    private KhachHang khachHang;  // Khách hàng

    @ManyToOne
    @JoinColumn(name = "HangHoa_id")
    private HangHoa hangHoa;  // Hàng hóa

    @Column(name = "SoLuong")
    private int soLuong;  // Số lượng mua

    @Column(name = "DonGia")
    private double donGia;  // Giá của mặt hàng

    @Column(name = "NgayTao")
    private LocalDate ngayTao;

    @Column(name = "TongTien")
    private double tongTien;

    @Column(name = "TrangThai")
    private String trangThai;
}
