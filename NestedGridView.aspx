<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NestedGridView.aspx.cs" Inherits="NestedGridView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<title>Nested GridView Example</title>
	<style type="text/css">
		body
		{
			font-family: Arial;
			font-size: 10pt;
		}
		.Grid td
		{
			background-color: White;
			color: Black;
			font-size: 10pt;
			line-height: 200%;
		}
		.Grid th
		{
			background-color: Navy;
			color: White;
			font-size: 10pt;
			line-height: 200%;
		}
		.ChildGrid td
		{
			background-color: Navy !important;
			color: White;
			font-size: 10pt;
			line-height: 200%;
		}
		.ChildGrid th
		{
			background-color: Black !important;
			color: White;
			font-size: 10pt;
			line-height: 200%;
		}
	</style>
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
	<script type="text/javascript">
		function divexpandcollapse(divname) {
			var img = "img" + divname;
			if ($("#" + img).attr("src") == "images/plus.png") {
				$("#" + img)
				.closest("tr")
				.after("<tr><td></td><td colspan = '100%'>" + $("#" + divname)
				.html() + "</td></tr>");
				$("#" + img).attr("src", "images/minus.png");
			} else {
				$("#" + img).closest("tr").next().remove();
				$("#" + img).attr("src", "images/plus.png");
			}
		}
	</script>
</head>
<body>
    <p>EDI Systems</p>
	<form id="form1" runat="server">
	<div>
        <div>New Div</div>
		<asp:GridView ID="grdViewCustomers" runat="server" AutoGenerateColumns="false" DataKeyNames="CustomerID"
			OnRowDataBound="grdViewCustomers_OnRowDataBound" CssClass="Grid">
			<Columns>
				<asp:TemplateField ItemStyle-Width="20px">
					<ItemTemplate>
						<a href="JavaScript:divexpandcollapse('div<%# Eval("CustomerID") %>');">
							<img alt="Details" id="imgdiv<%# Eval("CustomerID") %>" src="images/plus.png" />
						</a>
						<div id="div<%# Eval("CustomerID") %>" style="display: none;">
							<asp:GridView ID="grdViewOrdersOfCustomer" runat="server" AutoGenerateColumns="false"
								DataKeyNames="CustomerID" CssClass="ChildGrid">
								<Columns>
									<asp:BoundField ItemStyle-Width="150px" DataField="OrderID" HeaderText="Order ID" />
									<asp:BoundField ItemStyle-Width="150px" DataField="OrderDate" HeaderText="Order Date" />
								</Columns>
							</asp:GridView>
						</div>
					</ItemTemplate>
				</asp:TemplateField>
				<asp:BoundField ItemStyle-Width="150px" DataField="ContactName" HeaderText="Contact Name" />
				<asp:BoundField ItemStyle-Width="150px" DataField="City" HeaderText="City" />
			</Columns>
		</asp:GridView>
	</div>
	</form>
</body>
</html>
