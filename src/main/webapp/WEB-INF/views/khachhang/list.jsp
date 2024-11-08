<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <title>Danh Sách Khách Hàng</title>
    <style>
        .btn-group .btn {
            margin-right: 5px;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Danh Sách Khách Hàng</h2>

    <div class="d-flex justify-content-between mb-3">
        <form action="/khachhang" method="get" class="form-inline">
            <input type="text" name="search" value="${search}" class="form-control mr-2" placeholder="Tìm kiếm theo tên" aria-label="Search"/>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-search"></i> Tìm kiếm
            </button>
        </form>
        <div>
            <a href="/khachhang/download-sample-excel" class="btn btn-primary">Tải về File Excel Mẫu</a>

        </div>
    </div>

    <div class="w3-container">
        <button onclick="document.getElementById('id01').style.display='block'" class="btn btn-success"> <i class="fas fa-plus"></i> Thêm Khách Hàng Mới</button>

        <div id="id01" class="w3-modal">
            <div class="w3-modal-content">
                <header class="w3-container w3-teal">
        <span onclick="document.getElementById('id01').style.display='none'"
              class="w3-button w3-display-topright">&times;</span>
                    <h2>Thêm Khách Hàng Mới</h2>
                </header>
                <div class="w3-container">
                    <form action="/khachhang/create" method="post" class="mt-4">
                        <div class="form-group">
                            <label for="ma">Mã Khách Hàng:</label>
                            <input type="text" id="ma" name="ma" class="form-control" value="${khachHang.ma}" required />
                            <c:if test="${not empty errors['ma']}">
                                <div class="text-danger">${errors['ma']}</div>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <label for="ten">Tên Khách Hàng:</label>
                            <input type="text" id="ten" name="ten" class="form-control" value="${khachHang.ten}" required />
                            <c:if test="${not empty errors['ten']}">
                                <div class="text-danger">${errors['ten']}</div>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <label for="sdt">Số Điện Thoại:</label>
                            <input type="text" id="sdt" name="sdt" class="form-control" value="${khachHang.sdt}" required />
                            <c:if test="${not empty errors['sdt']}">
                                <div class="text-danger">${errors['sdt']}</div>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <label for="diemTL">Điểm Tích Lũy:</label>
                            <input type="number" id="diemTL" name="diemTL" class="form-control" value="${khachHang.diemTL}" required />
                            <c:if test="${not empty errors['diemTL']}">
                                <div class="text-danger">${errors['diemTL']}</div>
                            </c:if>
                        </div>

                        <button type="submit" class="btn btn-primary">Lưu</button>
                        <a href="/khachhang" class="btn btn-secondary">Quay lại</a>
                    </form>
                </div>

            </div>
        </div>
    </div>



    <!-- Form Upload File -->
    <form action="/khachhang/upload" method="post" enctype="multipart/form-data" class="mb-3">
        <div class="form-group">
            <label for="file">Chọn file thông tin khách hàng:</label>
            <input type="file" name="file" id="file" class="form-control" required/>
        </div>
        <button type="submit" class="btn btn-info">Tải lên</button>
    </form>

    <table class="table table-bordered table-striped table-hover">
        <thead class="thead-dark">
        <tr>
            <th>STT</th>
            <th>Mã Khách Hàng</th>
            <th>Tên Khách Hàng</th>
            <th>Số Điện Thoại</th>
            <th>Điểm Tích Lũy</th>
            <th>Ngày Tạo</th>
            <th>Ngày Sửa</th>
            <th>Hành Động</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${khachhangPage.content}" var="kh" varStatus="i">
            <tr>
                <td>${i.index + 1}</td>
                <td>${kh.ma}</td>
                <td>${kh.ten}</td>
                <td>${kh.sdt}</td>
                <td>${kh.diemTL}</td>
                <td>${kh.ngayTao}</td>
                <td>${kh.ngaySua}</td>
                <td>
                    <div class="btn-group" role="group" aria-label="Basic example">
                        <a href="/khachhang/edit/${kh.id}" class="btn btn-warning btn-sm">
                            <i class="fas fa-edit"></i> Sửa
                        </a>
                        <a href="/khachhang/delete/${kh.id}" class="btn btn-danger btn-sm" onclick="return confirm('Bạn có chắc chắn muốn xóa?');">
                            <i class="fas fa-trash"></i> Xóa
                        </a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
<%----%>
    <div class="text-center">
        <nav aria-label="Page navigation example">
            <ul class=" pagination">
                <li class="page-item ${currentPage == 0 ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage - 1}&size=${khachhangPage.size}&search=${search}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </a>
                </li>
                <c:forEach var="i" begin="0" end="${totalPages - 1}">
                    <li class="page-item ${i == currentPage ? 'active' : ''}">
                        <a class="page-link" href="?page=${i}&size=${khachhangPage.size}&search=${search}">${i + 1}</a>
                    </li>
                </c:forEach>
                <li class="page-item ${currentPage + 1 >= totalPages ? 'disabled' : ''}">
                    <a class="page-link" href="?page=${currentPage + 1}&size=${khachhangPage.size}&search=${search}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
<%----%>
    <BR>
</div>



<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
