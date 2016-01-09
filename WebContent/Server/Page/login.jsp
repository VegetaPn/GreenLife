<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">

<title>login</title>

<!-- Bootstrap Core CSS -->
<link href="../CSS/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<div class="login-panel panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title text-center">管理员登录</h3>
					</div>
					<%
						String error = "";
						String userId = "";
						if (!(session.getAttribute("error") == null)) {
							error = (String) session.getAttribute("error");
							userId = (String) session.getAttribute("userId");
						}
						if (userId == null) {
							userId = "";
						}
					%>
					<div class="panel-body">
						<form action="/ServerLoginServlet" method="post"
							onsubmit="return checkLogin()">
							<fieldset>
								<div class="form-group">
									<div class="input-group">
										<span class="input-group-addon">账户</span> <input
											class="form-control" name="userId" id="userId"
											value="<%=userId%>" autofocus />
									</div>
								</div>

								<div class="form-group">
									<div class="input-group">
										<span class="input-group-addon">密码</span> <input
											class="form-control" name="password" id="password" value=""
											type="password">
									</div>
								</div>
								<div class="form-group">
									<label style="color: red" id="content"><%=error%></label>
								</div>

								<input type="submit" class="btn btn-lg btn-success btn-block"
									value="登录" />
							</fieldset>
						</form>
					</div>


				</div>
			</div>
		</div>
	</div>

	<script src="../js/login.js" type="text/javascript"></script>
</body>

</html>