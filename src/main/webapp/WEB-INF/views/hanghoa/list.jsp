<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Quản lý Hàng Hóa</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <style>
        .btn-group .btn {
            margin-right: 5px;
        }
    </style>
    <script>
        function togglePagination(display) {
            const pagination = document.getElementById('pagination');
            pagination.style.display = display ? 'block' : 'none';
        }

        function openModal() {
            document.getElementById('id01').style.display = 'block';
            togglePagination(false); // Ẩn phân trang khi mở modal
        }

        function closeModal() {
            document.getElementById('id01').style.display = 'none';
            togglePagination(true); // Hiện lại phân trang khi đóng modal
        }
    </script>
</head>
<body>

<h1 class="text-center mb-4">Danh Sách Hàng Hóa</h1>

<form action="/hanghoa" method="get" class="form-inline mb-4 justify-content-between">
    <div class="input-group">
        <input type="text" name="search" class="form-control" placeholder="Tìm kiếm theo tên..." value="${search}">
        <div class="input-group-append">
            <button type="submit" class="btn btn-primary"><i class="fas fa-search"></i> Tìm Kiếm</button>
        </div>
    </div>

    <button type="button" onclick="openModal()" class="btn btn-success ml-3">
        <i class="fas fa-plus"></i> Thêm Mới Hàng Hóa
    </button>
</form>

<div id="id01" class="w3-modal">
    <div class="w3-modal-content">
        <header class="w3-container w3-teal">
            <span onclick="closeModal()"
                  class="w3-button w3-display-topright">&times;</span>
            <h2>Thêm Mới Hàng Hóa</h2>
        </header>
        <div class="w3-container">
            <form action="/hanghoa/save" method="post">
                <div class="form-group">
                    <label>Mã Hàng Hóa</label>
                    <input type="text" class="form-control" name="ma" required>
                </div>
                <div class="form-group">
                    <label>Tên Hàng Hóa</label>
                    <input type="text" class="form-control" name="ten" required>
                </div>
                <div class="form-group">
                    <label>Giá</label>
                    <input type="number" class="form-control" name="gia" required>
                </div>
                <div class="form-group">
                    <label>Số Lượng</label>
                    <input type="number" class="form-control" name="soLuong" required>
                </div>
                <div class="form-group">
                    <label>Đơn Vị</label>
                    <input type="text" class="form-control" name="donVi" required>
                </div>
                <div class="form-group">
                    <label>Ngày Nhập</label>
                    <input type="date" class="form-control" name="ngayNhap" required>
                </div>
                <div class="form-group">
                    <label>Thời Gian Ngày Nhập</label>
                    <input type="time" class="form-control" name="thoiGianNgayNhap" required>
                </div>
                <div class="form-group">
                    <label>Hạn Sử Dụng</label>
                    <input type="date" class="form-control" name="hanSuDung" required>
                </div>
                <div class="form-group">
                    <label>Thời Gian Hạn Sử Dụng</label>
                    <input type="time" class="form-control" name="thoiGianHSD" required>
                </div>
                <div class="form-group">
                    <label>Tổng Thành Phần</label>
                    <input type="text" class="form-control" name="tongThanhPhan" required>
                </div>
                <button type="submit" class="btn btn-success">Lưu</button>
            </form>
        </div>
    </div>
</div>

<div id="pagination">
    <table class="table table-striped table-bordered table-hover">
        <thead class="thead-dark">
        <tr>
            <th>STT</th>
            <th>Mã Hàng Hóa</th>
            <th>Tên Hàng Hóa</th>
            <th>Giá</th>
            <th>Số Lượng</th>
            <th>Đơn Vị</th>
            <th>Ngày Nhập</th>
            <th>Thời Gian Nhập</th>
            <th>Hạn Sử Dụng</th>
            <th>Thời Gian HSD</th>
            <th>Tổng Thành Phần</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="hangHoa" items="${hangHoaPage.content}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${hangHoa.ma}</td>
                <td>${hangHoa.ten}</td>
                <td>${hangHoa.gia}</td>
                <td>${hangHoa.soLuong}</td>
                <td>${hangHoa.donVi}</td>
                <td>${hangHoa.ngayNhap}</td>
                <td>${hangHoa.thoiGianNgayNhap}</td>
                <td>${hangHoa.hanSuDung}</td>
                <td>${hangHoa.thoiGianHSD}</td>
                <td>${hangHoa.tongThanhPhan}</td>
                <td>
                    <div class="btn-group" role="group">
                        <a href="${pageContext.request.contextPath}/hanghoa/edit/${hangHoa.id}" class="btn btn-warning btn-sm"><i class="fas fa-edit"></i> Sửa</a>
                        <a href="${pageContext.request.contextPath}/hanghoa/delete/${hangHoa.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?');"><i class="fas fa-trash"></i> Xóa</a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div>
        <nav aria-label="Page navigation">
            <ul class="pagination justify-content-center">
                <c:if test="${hangHoaPage.hasPrevious()}">
                    <li class="page-item">
                        <a class="page-link" href="/hanghoa?page=${hangHoaPage.number - 1}&search=${search}" aria-label="Trước">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:if>
                <c:forEach begin="0" end="${hangHoaPage.totalPages - 1}" var="i">
                    <li class="page-item ${hangHoaPage.number == i ? 'active' : ''}">
                        <a class="page-link" href="/hanghoa?page=${i}&search=${search}">${i + 1}</a>
                    </li>
                </c:forEach>
                <c:if test="${hangHoaPage.hasNext()}">
                    <li class="page-item">
                        <a class="page-link" href="/hanghoa?page=${hangHoaPage.number + 1}&search=${search}" aria-label="Sau">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:if>
            </ul>
        </nav>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
