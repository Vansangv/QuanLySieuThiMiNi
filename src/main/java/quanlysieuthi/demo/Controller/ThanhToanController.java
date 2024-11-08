package quanlysieuthi.demo.Controller;



import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.xwpf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import quanlysieuthi.demo.Etity.ChiTietHoaDon;
import quanlysieuthi.demo.Etity.HangHoa;
import quanlysieuthi.demo.Etity.KhachHang;
import quanlysieuthi.demo.Repository.ChiTietHoaDonRepository;
import quanlysieuthi.demo.Repository.HangHoaRepository;
import quanlysieuthi.demo.Repository.KhachHangRepository;

import java.io.IOException;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;


@Controller
public class ThanhToanController {
    @Autowired
    private ChiTietHoaDonRepository chiTietHoaDonRepository;

    @Autowired
    private HangHoaRepository hangHoaRepository;

    @Autowired
    private KhachHangRepository khachHangRepository;


    @GetMapping("/hienthi")
    public String showChiTietHoaDon(Model model) {
            model.addAttribute("chiTietHoaDon", chiTietHoaDonRepository.findAll());
            model.addAttribute("hangHoaList", hangHoaRepository.findAll());
            model.addAttribute("khachHangList", khachHangRepository.findAll());
        return "chiTietHoaDon";
    }



    @GetMapping("/danhSachChiTietHoaDon")
    public String danhSachChiTietHoaDon(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(required = false) String searchName,
            Model model) {

        List<ChiTietHoaDon> chiTietHoaDonList;

        // Nếu tìm kiếm theo tên
        if (searchName != null && !searchName.isEmpty()) {
            chiTietHoaDonList = chiTietHoaDonRepository.findByKhachHang_TenContainingOrHangHoa_TenContaining(searchName, searchName);
        }
        // Nếu tìm kiếm theo khoảng ngày
        else if (startDate != null && endDate != null) {
            chiTietHoaDonList = chiTietHoaDonRepository.findByNgayTaoBetween(startDate, endDate);
        }
        // Nếu không có điều kiện nào, lấy tất cả
        else {
            chiTietHoaDonList = chiTietHoaDonRepository.findAll();
        }

        model.addAttribute("chiTietHoaDon", chiTietHoaDonList);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("searchName", searchName);
        return "LichSuHoaDon"; // Tên của JSP
    }


    @PostMapping("/payment")
    public String processPayment(
            @RequestParam("maHoaDon") String maHoaDon,
            @RequestParam("khachHangId") Integer khachHangId,
            @RequestParam("hangHoaId") Integer hangHoaId,
            @RequestParam("soLuong") int soLuong,
            @RequestParam("donGia") double donGia,
            @RequestParam("tienKhachDua") double tienKhachDua,
            Model model) {

        // Tính tổng tiền
        double tongTien = soLuong * donGia;

        double tienThua = tienKhachDua - tongTien;
        // Lấy đối tượng KhachHang và HangHoa
        KhachHang khachHang = khachHangRepository.findById(khachHangId).orElse(null);
        HangHoa hangHoa = hangHoaRepository.findById(hangHoaId).orElse(null);

        if (hangHoa != null && hangHoa.getSoLuong() >= soLuong) {
            // Tạo đối tượng ChiTietHoaDon và thiết lập thuộc tính
            ChiTietHoaDon chiTietHoaDon = ChiTietHoaDon.builder()
                    .maHoaDon(maHoaDon)
                    .khachHang(khachHang)
                    .hangHoa(hangHoa)
                    .soLuong(soLuong)
                    .donGia(donGia)
                    .tongTien(tongTien)  // Gán tổng tiền đã tính
                    .ngayTao(LocalDate.now())
                    .trangThai("Ðã thanh toán")  // hoặc trạng thái khác nếu cần
                    .build();

            // Lưu vào cơ sở dữ liệu
            chiTietHoaDonRepository.save(chiTietHoaDon);

            // Cập nhật số lượng hàng hóa
            hangHoa.setSoLuong(hangHoa.getSoLuong() - soLuong);
            hangHoaRepository.save(hangHoa); // Lưu cập nhật

            // Thêm thông tin vào model để hiển thị trên trang kết quả
            model.addAttribute("message", "Thanh toán thành công!");
            model.addAttribute("chiTietHoaDon", chiTietHoaDon);
            model.addAttribute("tienKhachDua", tienKhachDua);
            model.addAttribute("tongTien", tongTien);
            model.addAttribute("tienThua", tienThua);
        } else {
            // Xử lý trường hợp không đủ hàng hóa
            model.addAttribute("message", "Số lượng hàng hóa không đủ để thanh toán!");
            return "errorPage"; // trang hiển thị thông báo lỗi
        }

        // Trả về trang kết quả hiển thị thông tin
        return "ketQuaThanhToan";  // trang JSP hiển thị kết quả thanh toán
    }




    @GetMapping("/exportWord")
    public void exportWord(@RequestParam String maHoaDon, @RequestParam String tenKhachHang,
                           @RequestParam String tenHangHoa, @RequestParam int soLuong,
                           @RequestParam double donGia, @RequestParam double tongTien,
                           @RequestParam double tienKhachDua, @RequestParam double tienThua,
                           HttpServletResponse response) throws IOException {
        XWPFDocument document = new XWPFDocument();

        // Tiêu đề hóa đơn
        XWPFParagraph titleParagraph = document.createParagraph();
        XWPFRun titleRun = titleParagraph.createRun();
        titleRun.setText("HÓA ĐƠN THANH TOÁN Siêu Thị MINI");
        titleRun.setBold(true);
        titleRun.setFontSize(24);
        titleRun.addBreak();
        titleRun.setText("Địa chỉ: 123 Đường ABC, Quận 1, TP.HCM");
        titleRun.setFontSize(12);
        titleRun.addBreak();
        titleRun.addBreak(); // Ngắt dòng thêm

        // Tạo bảng hóa đơn
        XWPFTable table = document.createTable(1, 2); // 1 hàng, 2 cột

        // Đặt tiêu đề cho bảng
        XWPFTableCell headerCell1 = table.getRow(0).getCell(0);
        headerCell1.setText("Thông Tin");

        XWPFTableCell headerCell2 = table.getRow(0).getCell(1);
        headerCell2.setText("Giá Trị");

        // Thêm thông tin hóa đơn
        int rowNum = 1; // Bắt đầu từ hàng thứ hai
        addRowToTable(table, rowNum++, "Mã Hóa Đơn", maHoaDon);
        addRowToTable(table, rowNum++, "Khách Hàng", tenKhachHang);
        addRowToTable(table, rowNum++, "Hàng Hóa", tenHangHoa);
        addRowToTable(table, rowNum++, "Số Lượng", String.valueOf(soLuong));
        addRowToTable(table, rowNum++, "Đơn Giá", String.valueOf(donGia));
        addRowToTable(table, rowNum++, "Tổng Tiền", String.valueOf(tongTien));
        addRowToTable(table, rowNum++, "Tiền Khách Đưa", String.valueOf(tienKhachDua));
        addRowToTable(table, rowNum++, "Tiền Thừa", String.valueOf(tienThua >= 0 ? tienThua : 0));
        addRowToTable(table, rowNum++, "Tiền Thiếu", String.valueOf(tienThua < 0 ? Math.abs(tienThua) : 0));

        // Định dạng bảng


        // Kết thúc hóa đơn
        XWPFParagraph footerParagraph = document.createParagraph();
        footerParagraph.createRun().setText("Cảm ơn bạn đã mua sắm tại Siêu Thị ABC!");
        footerParagraph.setAlignment(ParagraphAlignment.CENTER);

        // Thiết lập tiêu đề cho response
        response.setContentType("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
        response.setHeader("Content-Disposition", "attachment; filename=HoaDonThanhToan.docx");

        // Ghi nội dung vào response
        document.write(response.getOutputStream());
        document.close();
    }

    private void addRowToTable(XWPFTable table, int rowNum, String label, String value) {
        XWPFTableRow row = table.createRow();
        row.getCell(0).setText(label);
        row.getCell(1).setText(value);
    }

    private XWPFParagraph createCenteredParagraph(XWPFDocument document, String text) {
        XWPFParagraph paragraph = document.createParagraph();
        paragraph.setAlignment(ParagraphAlignment.CENTER);
        XWPFRun run = paragraph.createRun();
        run.setText(text);
        return paragraph;
    }
}



