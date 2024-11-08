package quanlysieuthi.demo.Etity;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;

import javax.xml.stream.XMLInputFactory;
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

//    @NotBlank(message = "Mã khách hàng không được để trống")
//    @Size(min = 3 ,max = 10, message = "Mã khách hàng phải từ 3 ký tự trở lên và không được vượt quá 10 ký tự")
    @Column(name = "MaKhachHang")
    private String ma;

//    @NotBlank(message = "Tên khách hàng không được để trống")
//    @Size(min = 6, max = 50, message = "Tên khách hàng phải có từ 6 đến 50 ký tự")
    @Column(name = "TenKhachHang")
    private String ten;
//
//    @NotBlank(message = "Số điện thoại không được để trống")
//    @Size(min = 10, message = "Số điện thoại phải là 10 chữ số")
    @Column(name = "SoDienThoai")
    private String sdt;

//    @NotNull(message = "Điểm tích lũy không được để trống")
//    @Min(value = 10, message = "Điểm tích lũy phải lớn hơn 10")
//    @Max(value = 999, message = "Điểm tích lũy phải nhỏ hơn 1000")
    @Column(name = "DiemTichLuy")
    private Integer diemTL;

    @Column(name = "NgayTao")
    private Date ngayTao;

    @Column(name = "NgaySua")
    private Date ngaySua;
}
