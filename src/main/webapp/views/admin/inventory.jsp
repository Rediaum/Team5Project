<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<h2>Inventory Management</h2>

<!-- Form untuk Tambah Produk Baru -->
<h3>Add Product</h3>
<form action="${pageContext.request.contextPath}/admin/inventory/add" method="post">
  <input type="text" name="productName" placeholder="Product Name" required />
  <textarea name="description" placeholder="Description"></textarea>
  <input type="number" name="productPrice" placeholder="Price" required />
  <input type="number" step="0.01" name="discountRate" placeholder="Discount Rate" />
  <input type="text" name="productImg" placeholder="Image URL" />
  <input type="number" name="categoryId" placeholder="Category ID" required />
  <button type="submit">Add Product</button>
</form>

<hr/>

<!-- Daftar Produk dan Form Edit -->
<h3>Product List</h3>
<table border="1" cellpadding="5" cellspacing="0">
  <thead>
  <tr>
    <th>ID</th><th>Name</th><th>Price</th><th>Discount</th><th>Actions</th>
  </tr>
  </thead>
  <tbody>
  <c:forEach var="p" items="${productList}">
    <tr>
      <form action="${pageContext.request.contextPath}/admin/inventory/update" method="post">
        <td>${p.productId}</td>
        <td>
          <input type="hidden" name="productId" value="${p.productId}" />
          <input type="text" name="productName" value="${p.productName}" />
        </td>
        <td><input type="number" name="productPrice" value="${p.productPrice}" /></td>
        <td><input type="number" step="0.01" name="discountRate" value="${p.discountRate}" /></td>
        <td>
          <input type="text" name="description" value="${p.description}" />
          <input type="text" name="productImg" value="${p.productImg}" />
          <input type="number" name="categoryId" value="${p.categoryId}" />
          <button type="submit">Update</button>
        </td>
      </form>
    </tr>
  </c:forEach>
  </tbody>
</table>
