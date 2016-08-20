using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class NestedGridView : System.Web.UI.Page
{
	protected void Page_Load(object sender, EventArgs e)
	{
		grdViewCustomers.DataSource = SelectData("SELECT top 3 CustomerID, ContactName, City FROM Customers");
		grdViewCustomers.DataBind();
	}

	private DataTable SelectData(string sqlQuery)
	{
		string connectionString = System.Web.Configuration.WebConfigurationManager.ConnectionStrings["SQLServerConnectionString"].ConnectionString;
		using (SqlDataAdapter sqlDataAdapter = new SqlDataAdapter(sqlQuery, connectionString))
		{
			DataTable dt = new DataTable("Customers");
			sqlDataAdapter.Fill(dt);
			return dt;
		}
	}

	protected void grdViewCustomers_OnRowDataBound(object sender, GridViewRowEventArgs e)
	{
		if (e.Row.RowType == DataControlRowType.DataRow)
		{
			string customerID = grdViewCustomers.DataKeys[e.Row.RowIndex].Value.ToString();
			GridView grdViewOrdersOfCustomer = (GridView)e.Row.FindControl("grdViewOrdersOfCustomer");
			grdViewOrdersOfCustomer.DataSource = SelectData("SELECT top 3 CustomerID, OrderID, OrderDate FROM Orders WHERE CustomerID='" + customerID + "'");
			grdViewOrdersOfCustomer.DataBind();
		}
	}
}