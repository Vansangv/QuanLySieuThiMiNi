package quanlysieuthi.demo.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping({"/trangchu", "/"})
public class Trang_cHU {


    @GetMapping
    public String listHangHoa() {
        return "TrangChu";
    }
}
