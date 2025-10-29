<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*,model.Project"%>
<!DOCTYPE html>
<html>
<head>
<title>Software Project Catalog</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/styles.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="d-flex justify-content-end mb-3">
  <div class="emp-actionbar">
    <button id="btnAddProject" type="button" class="btn btn-primary">➕ New Project</button>
    <button type="submit" form="projectForm" class="btn btn-outline">💾 Save Project</button>
  </div>
</div>

	<div class="container bg-orange-300">
		<div class="header">
			<h1>Сэдвийн цуглуулга</h1>
			<div class="top-right">
				<form class="form-inline"
					action="<%=request.getContextPath()%>/project/add" method="post">
					<input type="text" name="name" placeholder="Project name" required>
					<input type="text" name="name_en" placeholder="Project name (EN)" required>
					<input type="text" name="owner" placeholder="Owner" required>
					<input type="text" name="github" placeholder="Github Repo Link" required>
					<button class="btn" type="submit">Шинэ сэдэв</button>
				</form>
			</div>
		</div>

		<div class="table-wrap">
			<table>
				<thead>
					<tr>
						<th>ID</th>
						<th>Сэдвийн нэр</th>
						<th>Сэдвийн нэр (Англи)</th>
						<th>Оюутны нэр</th>
						<th>Github Link?</th>
						<th>Үйлдэл</th>
					</tr>
				</thead>
				<tbody>
					<%
					List<Project> projects = (List<Project>) request.getAttribute("projects");
					if (projects != null) {
						for (Project p : projects) {
					%>
					<tr>
						<td><%=p.getId()%></td>
						<td><%=p.getName()%></td>
						<td><%=p.getNameEN()%></td>
						<td><%=p.getOwner()%></td>
						<td><a href="<%=p.getGithub()%>"><%=p.getGithub()%></a></td>
						<td>
							<div class="actions">
								<button class="btn btn-sm" onclick="openModal(<%=p.getId()%>)">Дэлгэрэнгүй</button>
							</div>
						</td>
					</tr>
					<%
					}
					}
					%>
				</tbody>
			</table>
		</div>
	</div>

	<div class="modal fade" id="projectModal" tabindex="-1"
		aria-hidden="true">
		<div class="modal-dialog modal-lg modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">Project Details</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				</div>
				<div class="modal-body" id="modalBody"></div>
			</div>
		</div>
	</div>

	<form id="uploadForm"
		action="<%=request.getContextPath()%>/file/upload" method="post"
		enctype="multipart/form-data" style="display: none">
		<input type="hidden" name="projectId" id="uploadProjectId"> <input
			type="file" name="file" id="fileInput"
			onchange="document.getElementById('uploadForm').submit()">
	</form>

	<script>
function openModal(id){
  fetch('<%=request.getContextPath()%>/project?id='+id,{headers:{'X-Requested-With':'XMLHttpRequest'}})
    .then(r=>r.text())
    .then(html=>{
      document.getElementById('modalBody').innerHTML=html
      new bootstrap.Modal(document.getElementById('projectModal')).show()
    })
}
function triggerUpload(id){
  document.getElementById('uploadProjectId').value=id
  document.getElementById('fileInput').click()
}
</script>

<div id="cmBackdrop" class="corner-modal-backdrop"></div>
<div id="cornerModal" class="corner-modal emp-glass" role="dialog" aria-modal="true" aria-labelledby="cmTitle">
  <div class="cm-header">
    <div class="d-flex align-items-center gap-2">
      <span class="badge-soft">New</span>
      <h6 id="cmTitle" class="m-0">Add / Edit Project</h6>
    </div>
    <button type="button" class="cm-close" id="cmCloseBtn">&times;</button>
  </div>
  <div class="cm-body">
    <jsp:include page="modal.jsp" flush="true" />
  </div>
</div>

<script>
  (function(){
    const addBtn = document.getElementById('btnAddProject');
    const backdrop = document.getElementById('cmBackdrop');
    const modal = document.getElementById('cornerModal');
    const closeBtn = document.getElementById('cmCloseBtn');

    function openCornerModal(){
      backdrop.classList.add('show');
      modal.classList.add('show');
      document.body.style.overflow = 'hidden';
    }
    function closeCornerModal(){
      backdrop.classList.remove('show');
      modal.classList.remove('show');
      document.body.style.overflow = '';
    }

    if(addBtn){ addBtn.addEventListener('click', openCornerModal); }
    if(backdrop){ backdrop.addEventListener('click', closeCornerModal); }
    if(closeBtn){ closeBtn.addEventListener('click', closeCornerModal); }
    // Close on ESC
    document.addEventListener('keydown', (e)=>{ if(e.key === 'Escape'){ closeCornerModal(); } });
  })();
</script>

</body>
</html>
