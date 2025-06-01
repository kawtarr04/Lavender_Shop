<nav>
		<div class="navbar">
			<a href="index.jsp"><img src="product-image/logo.png" alt="Logo" class="logo" style="width: 300px; height: 200px;"></a>

			<ul>

				<% if (auth != null) { %>
				<li><a href="index.jsp">Accueil</a></li>

				<% if ("admin".equals(auth.getRole())) { %>
				<li><a href="admin.jsp">Dashboard</a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle">Profile</a>
					<div class="dropdown-menu">
						<a href="settings.jsp">Espace Admin</a>
						<div class="divider"></div>
						<a href="log-out">Logout</a>
					</div></li>
				<% } else { %>
				<li>
					<a href="cart.jsp">Panier
						<span class="badge">${cart_list.size()}</span>
					</a>
				</li>
				<li><a href="orders.jsp">Commandes</a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle">Profile</a>
					<div class="dropdown-menu">
						<a href="settings.jsp">Espace Membre</a>
						<div class="divider"></div>
						<a href="log-out">Logout</a>
					</div></li>
				<% } %>
				<% } else { %>
				<li><a href="index.jsp">Accueil</a></li>
				<li>
					<a href="cart.jsp">Panier
						<span class="badge">${cart_list.size()}</span>
					</a>
				</li>
				<li><a href="login.jsp">Login</a></li>
				<% } %>
			</ul>

		</div>

</nav>
<style>


	.dropdown {
		position: relative;
	}

	.dropdown-menu {
		display: none;
		position: absolute;
		top: 100%;
		left: 0;
		background-color: #ae95dd;
		box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
		padding: 10px;
	}

	.dropdown:hover .dropdown-menu {
		display: block;
	}

	.dropdown-menu a {
		display: block;
		padding: 5px 10px;
		background-color: #ae95dd;

		text-decoration: none;
	}



	.dropdown-menu a:hover {
		color: black;
		background-color: #f2e5fb;
	}

	/* Divider Styling */
	.divider {
		height: 1px;
		background-color: #e4befb;
		margin: 5px 0;
	}
</style>