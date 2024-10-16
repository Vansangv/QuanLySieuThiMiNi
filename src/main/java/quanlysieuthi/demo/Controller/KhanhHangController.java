package quanlysieuthi.demo.Controller;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import quanlysieuthi.demo.Etity.KhachHang;
import quanlysieuthi.demo.Repository.KhachHangRepository;
import org.springframework.web.multipart.MultipartFile;
import org.apache.poi.ss.usermodel.*;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/khachhang") // Đường dẫn cho các yêu cầu liên quan đến khách hàng
public class KhanhHangController {

    @Autowired
    private KhachHangRepository khachHangRepository;

    //Phương thức để hiển thị danh sách khách hàng
    @GetMapping
    public String listKhachHang(@RequestParam(value = "search", required = false) String search, Model model) {
        List<KhachHang> khachHangs;
        // Tìm kiếm theo tên nếu có tham số tìm kiếm
        if (search != null && !search.isEmpty()) {
            khachHangs = khachHangRepository.findByTenContaining(search);
        } else {
            khachHangs = khachHangRepository.findAllByOrderByNgayTaoDesc(); // Sắp xếp theo ngày tạo mới nhất
        }
        //khachHangs.sort((a, b) -> b.getNgayTao().compareTo(a.getNgayTao()));
        model.addAttribute("khachHangs", khachHangs); // Thêm danh sách khách hàng vào model
        model.addAttribute("search", search); // Thêm tham số tìm kiếm vào model
        return "khachhang/list";
    }

    @GetMapping("/download-sample-excel")
    public ResponseEntity<byte[]> downloadSampleExcel() throws IOException {

        XSSFWorkbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Mẫu Thông Tin");

        Row headerRow = sheet.createRow(0);
        String[] columns = {"MaKhachHang", "TenKhachHang", "SoDienThoai", "DiemTichLuy", "NgayTao","NgaySua"};

        for (int i = 0; i < columns.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columns[i]);
        }

        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        workbook.write(outputStream);
        workbook.close();

        byte[] bytes = outputStream.toByteArray();

        // Thiết lập header cho phản hồi
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=sample.xlsx");

        return new ResponseEntity<>(bytes, headers, HttpStatus.OK);
    }
//
    @PostMapping("/upload")
    public String uploadFile(@RequestParam("file") MultipartFile file) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(file.getInputStream()))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] fields = line.split("");
                KhachHang khachHang = new KhachHang();
                khachHang.setMa(fields[0]);
                khachHang.setTen(fields[1]);
                khachHang.setSdt(fields[2]);
                khachHang.setDiemTL(Integer.parseInt(fields[3]));
                khachHang.setNgayTao(new Date());
                khachHangRepository.save(khachHang);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "redirect:/khachhang";
    }

//



    // Phương thức hiển thị form tạo mới khách hàng
    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("khachHang", new KhachHang()); // Tạo đối tượng mới để gửi lên form
        return "khachhang/create"; // Trả về view tạo khách hàng
    }

    // Phương thức xử lý lưu khách hàng mới
    @PostMapping("/create")
    public String create(@ModelAttribute KhachHang khachHang) {
        khachHang.setNgayTao(new Date()); // Thiết lập ngày tạo
        khachHang.setNgaySua(new Date()); // Thiết lập ngày sửa
        khachHangRepository.save(khachHang); // Lưu khách hàng vào cơ sở dữ liệu
        return "redirect:/khachhang"; // Chuyển hướng về danh sách khách hàng
    }

    // Phương thức hiển thị form chỉnh sửa khách hàng
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id, Model model) {
        KhachHang khachHang = khachHangRepository.findById(id).orElseThrow(() -> new IllegalArgumentException("Invalid ID")); // Tìm khách hàng theo ID
        model.addAttribute("khachHang", khachHang); // Thêm khách hàng vào model
        return "khachhang/edit"; // Trả về view chỉnh sửa khách hàng
    }

    // Phương thức xử lý lưu khách hàng đã chỉnh sửa
    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, @ModelAttribute KhachHang khachHang) {
        khachHang.setId(id); // Thiết lập ID cho khách hàng
        khachHang.setNgayTao(new Date()); // Thiết lập ngày tạo
        khachHang.setNgaySua(new Date()); // Cập nhật ngày sửa
        khachHangRepository.save(khachHang); // Lưu khách hàng vào cơ sở dữ liệu
        return "redirect:/khachhang"; // Chuyển hướng về danh sách khách hàng
    }

    // Phương thức xóa khách hàng
    @GetMapping("/delete/{id}")
    public String delete(@PathVariable Integer id) {
        khachHangRepository.deleteById(id); // Xóa khách hàng theo ID
        return "redirect:/khachhang"; // Chuyển hướng về danh sách khách hàng
    }
}
