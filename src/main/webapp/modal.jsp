<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.*,model.Project,model.Document"%>
<%
Project p = (Project) request.getAttribute("project");
List<Document> docs = (List<Document>) request.getAttribute("documents");
%>
<form action="<%=request.getContextPath()%>/project/update"
	method="post">
	<input type="hidden" name="id" value="<%=p.getId()%>">
	<div class="mb-3">
		<label class="form-label">Сэдвийн нэр</label> <input type="text"
			class="form-control" name="name" value="<%=p.getName()%>" required>
	</div>
	<div class="mb-3">
		<label class="form-label">Сэдвийн нэр (EN)</label> <input type="text"
			class="form-control" name="name_en" value="<%=p.getNameEN()%>"
			required>
	</div>
	<div class="mb-3">
		<label class="form-label">Оюутны нэр</label> <input type="text"
			class="form-control" name="owner" value="<%=p.getOwner()%>" required>
	</div>
	<div class="mb-3">
		<label class="form-label">GitHub Link</label> <input type="text"
			class="form-control" name="github"
			value="<%=p.getGithub() == null ? "" : p.getGithub()%>">
	</div>
	<div class="mb-3">
		<label class="form-label">Comments/Notes</label>
		<textarea class="form-control" name="notes" rows="4"><%=p.getNotes() == null ? "" : p.getNotes()%></textarea>
	</div>
	<button type="submit" class="btn">Хадгалах</button>
</form>

<hr class="my-4">
