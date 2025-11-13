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
	<div class="p-4 md:p-6 lg:p-12 container">
		<div
			class="d-flex justify-content-between header align-items-center mb-3">

			<h1 class="w-50 m-0">Сэдвийн цуглуулга</h1>

			<div class="w-50 d-flex justify-content-end">
				<div class="emp-actionbar">
					<button id="btnAddProject" type="button" class="btn btn-primary">➕
						Шинэ сэдэв</button>
				</div>
			</div>

		</div>
		<div class="filter-wrap emp-glass p-3 mb-3">
			<div class="row g-3">
				<div class="col-md-6">
					<label for="filterName" class="form-label">Сэдвийн нэрээр
						хайх</label> <input type="text" id="filterName" class="form-control"
						placeholder="Сэдвийн нэр...">
				</div>
				<div class="col-md-6">
					<label for="filterNameEN" class="form-label">Сэдвийн нэр
						(Англи)-аар хайх</label> <input type="text" id="filterNameEN"
						class="form-control" placeholder="Сэдвийн нэр (Англи)...">
				</div>
			</div>
		</div>
		<div class="table-wrap emp-glass p-3">
			<table class="table align-middle">
				<thead>
					<tr>
						<th>ID</th>
						<th>Сэдвийн нэр</th>
						<th>Сэдвийн нэр (Англи)</th>
						<th>Оюутны нэр</th>
						<th>Github Link</th>
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
						<td>
							<%
							if (p.getGithub() != null && !p.getGithub().isEmpty()) {
							%> <a href="<%=p.getGithub()%>" target="_blank"
							class="badge-soft github-link">Link</a> <%
 } else {
 %> - <%
 }
 %>
						</td>
						<td>
							<div class="actions">
								<button class="btn btn-outline btn-sm"
									onclick="openModal(<%=p.getId()%>)">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
										fill="currentColor" class="bi bi-info-circle"
										viewBox="0 0 16 16">
                                        <path
											d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16" />
                                        <path
											d="m8.93 6.5l.235-4.275a.5.5 0 0 0-.965-.11l-.234 4.275a.5.5 0 0 0 .965.11M8 8.5a.5.5 0 0 0 .5.5h.5a.5.5 0 0 0 .5-.5v-4a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5z" />
                                    </svg>
									Дэлгэрэнгүй
								</button>
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
					<h5 class="modal-title">Сэдвийн дэлгэрэнгүй</h5>
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
// RESTORED: openModal function
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
	<div id="cornerModal" class="corner-modal emp-glass" role="dialog"
		aria-modal="true" aria-labelledby="cmTitle">
		<div class="cm-header">
			<div class="d-flex align-items-center gap-2">
				<span class="badge-soft">Сэдэв нэмэх</span>
				<h6 id="cmTitle" class="m-0">Сэдвийн мэдээлэл</h6>
			</div>
			<button type="button" class="cm-close" id="cmCloseBtn">&times;</button>
		</div>
		<div class="cm-body">
			<form action="<%=request.getContextPath()%>/project/add"
				method="post" id="addProjectForm">
				<div class="mb-3">
					<label class="form-label">Сэдвийн нэр</label> <input type="text"
						class="form-control" name="name" required>
				</div>
				<div class="mb-3">
					<label class="form-label">Сэдвийн нэр (EN)</label> <input
						type="text" class="form-control" name="name_en" required>
				</div>
				<div class="mb-3">
					<label class="form-label">Оюутны нэр</label> <input type="text"
						class="form-control" name="owner" required>
				</div>
				<div class="mb-3">
					<label class="form-label">GitHub Link</label> <input type="text"
						class="form-control" name="github" required>
				</div>
				<button type="submit" class="btn btn-primary">Шинэ сэдэв
					нэмэх</button>
			</form>

		</div>
	</div>
	<script>
  // Filter logic
  (function() {
    const filterNameInput = document.getElementById('filterName');
    const filterNameENInput = document.getElementById('filterNameEN');
    const tableBody = document.querySelector('.table tbody');

    function filterTable() {
      // Check if tableBody exists before getting rows
      if (!tableBody) return; 
      
      const tableRows = tableBody.getElementsByTagName('tr');
      const filterName = filterNameInput.value.toLowerCase();
      const filterNameEN = filterNameENInput.value.toLowerCase();

      for (let i = 0; i < tableRows.length; i++) {
        const row = tableRows[i];
        const nameCell = row.getElementsByTagName('td')[1]; // 2nd cell
        const nameENCell = row.getElementsByTagName('td')[2]; // 3rd cell

        if (nameCell && nameENCell) {
          const nameText = nameCell.textContent || nameCell.innerText;
          const nameENText = nameENCell.textContent || nameENCell.innerText;

          const nameMatch = nameText.toLowerCase().includes(filterName);
          const nameENMatch = nameENText.toLowerCase().includes(filterNameEN);

          if (nameMatch && nameENMatch) {
            row.style.display = ""; // Show row
          } else {
            row.style.display = "none"; // Hide row
          }
        }
      }
    }

    if(filterNameInput) {
        filterNameInput.addEventListener('keyup', filterTable);
    }
    if(filterNameENInput) {
        filterNameENInput.addEventListener('keyup', filterTable);
    }

  })();
	</script>
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

    // Note: addBtn is commented out in HTML, so this won't fire unless uncommented.
    if(addBtn){ addBtn.addEventListener('click', openCornerModal); }
    if(backdrop){ backdrop.addEventListener('click', closeCornerModal);
}
    if(closeBtn){ closeBtn.addEventListener('click', closeCornerModal); }
    // Close on ESC
    document.addEventListener('keydown', (e)=>{ if(e.key === 'Escape'){ closeCornerModal(); } });
})();
</script>

</body>
</html>