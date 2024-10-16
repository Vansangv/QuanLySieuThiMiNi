<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
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
            <a href="/khachhang/create" class="btn btn-success">
                <i class="fas fa-plus"></i> Thêm Khách Hàng Mới
            </a>
            <a href="/khachhang/download-sample-excel" class="btn btn-primary">Tải về File Excel Mẫu</a>

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
        <c:forEach items="${khachHangs}" var="kh" varStatus="i">
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

</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
