<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Hóa Đơn</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Chi Tiết Hóa Đơn</h2>

    <form action="${pageContext.request.contextPath}/payment" method="post">
        <div class="form-group">
            <label>Mã Hóa Đơn:</label>
            <input type="text" class="form-control" name="maHoaDon" required>
        </div>
        <div class="form-group">
            <label for="khachHang">Khách Hàng:</label>
            <select class="form-control" id="khachHang" name="khachHangId" required>
                <option value="" disabled selected>Chọn khách hàng</option>
                <c:forEach var="khachHang" items="${khachHangList}">
                    <option value="${khachHang.id}">${khachHang.ten}</option>
                </c:forEach>
            </select>

        </div>
        <div class="form-group">
            <label for="hangHoa">Hàng Hóa:</label>
            <select class="form-control" id="hangHoa" name="hangHoaId" required>
                <option value="" disabled selected>Chọn hàng hóa</option>
                <c:forEach var="hangHoa" items="${hangHoaList}">
                    <option value="${hangHoa.id}">${hangHoa.ten}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group">
            <label>Số Lượng:</label>
            <input type="number" class="form-control" name="soLuong" required oninput="calculateTotal()">
        </div>
        <div class="form-group">
            <label>Đơn Giá:</label>
            <input type="number" class="form-control" name="donGia" required oninput="calculateTotal()">
        </div>
        <div class="form-group">
            <label>Tổng Tiền:</label>
            <input type="text" class="form-control" name="tongTien" id="tongTien" readonly>
        </div>
        <div class="form-group">
            <label>Tiền Khách Đưa:</label>
            <input type="number" class="form-control" name="tienKhachDua" required oninput="calculateChange()">
        </div>
        <div class="form-group">
            <label>Tiền Thừa:</label>
            <input type="text" class="form-control" name="tienThua" id="tienThua" readonly>
        </div>
        <div class="form-group">
            <label>Tiền Thiếu:</label>
            <input type="text" class="form-control" name="tienThieu" id="tienThieu" readonly>
        </div>
        <button type="submit" class="btn btn-primary">Thanh Toán</button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
    function calculateTotal() {
        var soLuong = document.getElementsByName('soLuong')[0].value;
        var donGia = document.getElementsByName('donGia')[0].value;
        var tongTien = soLuong * donGia;
        document.getElementById('tongTien').value = tongTien;
        calculateChange(); // Gọi hàm tính tiền thừa và thiếu
    }

    function calculateChange() {
        var tongTien = document.getElementById('tongTien').value;
        var tienKhachDua = document.getElementsByName('tienKhachDua')[0].value;

        if (tongTien && tienKhachDua) {
            var thua = tienKhachDua - tongTien;
            document.getElementById('tienThua').value = (thua > 0) ? thua : 0;
            document.getElementById('tienThieu').value = (thua < 0) ? -thua : 0;
        } else {
            document.getElementById('tienThua').value = '';
            document.getElementById('tienThieu').value = '';
        }
    }
</script>
</body>
</html>
