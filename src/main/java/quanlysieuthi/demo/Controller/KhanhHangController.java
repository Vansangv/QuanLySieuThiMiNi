package quanlysieuthi.demo.Controller;

import jakarta.validation.Valid;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import quanlysieuthi.demo.Etity.KhachHang;
import quanlysieuthi.demo.Repository.KhachHangRepository;
import org.apache.poi.ss.usermodel.*;

import java.io.*;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Date;

import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/khachhang") // Đường dẫn cho các yêu cầu liên quan đến khách hàng
public class KhanhHangController {

    @Autowired
    private KhachHangRepository khachHangRepository;



    @GetMapping// Đảm bảo bạn có đường dẫn chính xác
    public String listKhachHang(
            @RequestParam(value = "search", required = false) String search,
            Model model,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size) {

        // Tạo đối tượng Pageable
        Pageable pageable = PageRequest.of(page, size, Sort.by("ngayTao").descending());

        Page<KhachHang> khachHangPage;

        // Tìm kiếm theo tên nếu có tham số tìm kiếm
        if (search != null && !search.isEmpty()) {
            khachHangPage = khachHangRepository.findByTenContaining(search, pageable);
        } else {
            khachHangPage = khachHangRepository.findAll(pageable); // Lấy tất cả và phân trang
        }

        // Thêm danh sách khách hàng vào model
        model.addAttribute("khachhangPage", khachHangPage);
        model.addAttribute("search", search); // Thêm tham số tìm kiếm vào model
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", khachHangPage.getTotalPages());

        return "khachhang/list"; // Tên JSP
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


//

    // Phương thức hiển thị form tạo mới khách hàng
    @GetMapping("/create")
    public String createForm(Model model) {
        model.addAttribute("khachHang", new KhachHang()); // Tạo đối tượng mới để gửi lên form
        return "khachhang/create"; // Trả về view tạo khách hàng
    }

    @PostMapping("/create")
    public String create(@ModelAttribute @Valid KhachHang khachHang, BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("khachHang", khachHang);
            model.addAttribute("errors", result.getFieldErrors().stream()
                    .collect(Collectors.toMap(FieldError::getField, FieldError::getDefaultMessage)));
            // Nếu có lỗi, trở lại form tạo
            return "khachhang/create"; // Trả về lại view để hiển thị lỗi
        }

        khachHang.setNgayTao(new Date());
        khachHang.setNgaySua(new Date());
        khachHangRepository.save(khachHang);
        return "redirect:/khachhang"; // Chuyển hướng về danh sách khách hàng
    }

    // Phương thức hiển thị form chỉnh sửa khách hàng
    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable Integer id, Model model) {
        KhachHang khachHang = khachHangRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Invalid ID")); // Tìm khách hàng theo ID
        model.addAttribute("khachHang", khachHang); // Thêm khách hàng vào model
        return "khachhang/edit"; // Trả về view chỉnh sửa khách hàng
    }

    // Phương thức xử lý lưu khách hàng đã chỉnh sửa
    @PostMapping("/edit/{id}")
    public String edit(@PathVariable Integer id, @Valid @ModelAttribute("khachHang") KhachHang khachHang,
                       BindingResult result, Model model) {
        if (result.hasErrors()) {
            model.addAttribute("khachHang", khachHang);
            return "khachhang/edit"; // Nếu có lỗi, trả về form chỉnh sửa với thông báo lỗi
        }
        khachHang.setId(id); // Thiết lập ID cho khách hàng
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




    @PostMapping("/upload")
    public String uploadExcelFile(@RequestParam("file") MultipartFile file) {
        if (file.isEmpty()) {
            return "Vui lòng chọn file!";
        }

        try (InputStream inputStream = file.getInputStream();
             Workbook workbook = new XSSFWorkbook(inputStream)) {

            Sheet sheet = workbook.getSheetAt(0);
            for (int i = 1; i <= sheet.getLastRowNum(); i++) {  // Bỏ qua dòng tiêu đề
                Row row = sheet.getRow(i);
                if (row == null) continue;

                KhachHang khachHang = new KhachHang();

                // Lấy mã khách hàng
                khachHang.setMa(row.getCell(0).getStringCellValue());

                // Lấy tên khách hàng
                khachHang.setTen(row.getCell(1).getStringCellValue());

                // Lấy số điện thoại

                khachHang.setSdt(row.getCell(2).getStringCellValue());

                // Lấy điểm tích lũy, đảm bảo là giá trị số
                if (row.getCell(3) != null && row.getCell(3).getCellType() == CellType.NUMERIC) {
                    khachHang.setDiemTL((int) row.getCell(3).getNumericCellValue());
                }

                // Lưu khách hàng vào cơ sở dữ liệu
                khachHangRepository.save(khachHang);
            }

            return "Tải lên thành công!";
        } catch (IOException e) {
            e.printStackTrace();
            return "Lỗi khi đọc file!";
        }

    }
}
