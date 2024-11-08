package quanlysieuthi.demo.Repository;

import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import quanlysieuthi.demo.Etity.ChiTietHoaDon;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Repository
public interface ChiTietHoaDonRepository extends JpaRepository<ChiTietHoaDon,Integer> {
    List<ChiTietHoaDon> findByNgayTaoBetween(LocalDate startDate, LocalDate endDate);
    List<ChiTietHoaDon> findByKhachHang_TenContainingOrHangHoa_TenContaining(String khachHangName, String hangHoaName);
}
