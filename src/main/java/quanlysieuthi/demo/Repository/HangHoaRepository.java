package quanlysieuthi.demo.Repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import quanlysieuthi.demo.Etity.HangHoa;

@Repository
public interface HangHoaRepository extends JpaRepository<HangHoa,Integer> {

    Page<HangHoa> findByTenContaining(String ten, Pageable pageable);
}
