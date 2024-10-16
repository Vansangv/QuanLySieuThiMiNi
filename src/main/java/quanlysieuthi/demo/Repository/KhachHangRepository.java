package quanlysieuthi.demo.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import quanlysieuthi.demo.Etity.KhachHang;

import java.util.List;

public interface KhachHangRepository extends JpaRepository<KhachHang,Integer> {
    List<KhachHang> findByTenContaining(String ten);
    List<KhachHang> findAllByOrderByNgayTaoDesc();
}
