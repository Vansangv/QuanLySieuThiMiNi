package quanlysieuthi.demo.Repository;


import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import quanlysieuthi.demo.Etity.KhachHang;


@Repository
public interface KhachHangRepository extends JpaRepository<KhachHang,Integer>{
    Page<KhachHang> findAll(Pageable pageable);
    Page<KhachHang> findByTenContaining(String ten, Pageable pageable);

}
