package quanlysieuthi.demo.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import quanlysieuthi.demo.Etity.HangHoa;
import quanlysieuthi.demo.Repository.HangHoaRepository;


@Controller
@RequestMapping("/hanghoa")
public class HangHoaController {
    @Autowired
    private HangHoaRepository hangHoaRepository;



    @GetMapping
    public String listHangHoa(@RequestParam(value = "search", required = false, defaultValue = "") String search,
                              @RequestParam(value = "page", defaultValue = "0") int page,
                              Model model) {
        Pageable pageable = PageRequest.of(page, 5, Sort.by(Sort.Direction.DESC, "id")); // Sắp xếp theo ID giảm dần
        Page<HangHoa> hangHoaPage;


        if (search.isEmpty()) {
            hangHoaPage = hangHoaRepository.findAll(pageable);
        } else {
            hangHoaPage = hangHoaRepository.findByTenContaining(search, pageable);
        }

        model.addAttribute("hangHoaPage", hangHoaPage);
        model.addAttribute("search", search);
        return "hanghoa/list"; // Chuyển đến trang danh sách
    }

    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("hangHoa", new HangHoa());
        return "hanghoa/create";
    }

    @PostMapping("/save")
    public String save(@ModelAttribute HangHoa hangHoa) {
        hangHoaRepository.save(hangHoa);
        return "redirect:/hanghoa";
    }


    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id, Model model) {
        HangHoa hangHoa = hangHoaRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Invalid HangHoa ID: " + id));
        model.addAttribute("hangHoa", hangHoa);
        return "hanghoa/edit"; // Chuyển đến trang edit
    }

    @PostMapping("/update")
    public String update(@ModelAttribute HangHoa hangHoa) {
        hangHoaRepository.save(hangHoa);
        return "redirect:/hanghoa"; // Sau khi cập nhật, chuyển hướng về danh sách
    }
    @GetMapping("/delete/{id}")
    public String deleteHangHoa(@PathVariable Integer id) {
        hangHoaRepository.deleteById(id);
        return "redirect:/hanghoa";
    }

}
