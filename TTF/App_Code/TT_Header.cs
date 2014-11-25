using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace TTF.App_Code
{
    public class TT_Header
    {
        public Int64 CustomerId { get; set; }
        public string FormType { get; set; } 
        public string Name { get; set; }
        public DateTime CustBirthDate { get; set; }
        public string FrameName { get; set; }
        public DateTime EnterDate { get; set; }
        public string URName { get; set; }
        public DateTime CustEventDate { get; set; }

        public string CustEventId { get; set; }
        public int Frm_CatID { get; set; }

        Util u;

        public TT_Header()
        {
            CustomerId = (HttpContext.Current.Request.QueryString["ID"] == null ? 50631332 : Int64.Parse(HttpContext.Current.Request.QueryString["ID"]));
            CustEventId = (HttpContext.Current.Request.QueryString["E"] == null ? "NULL" : HttpContext.Current.Request.QueryString["E"].ToString());
            Frm_CatID = (HttpContext.Current.Request.QueryString["F"] == null ? 122 : int.Parse(HttpContext.Current.Request.QueryString["F"]));
            FormType = "תוכנית תמיכות";
            Name = "מה זה";
       //     URName =(string) HttpContext.Current.Session["UserName"];
            u = new Util();
        }
       public DataTable getHeader()
        {
            SqlConnection cn = u.sqlConn;
            SqlCommand cD = new SqlCommand(string.Format("SELECT '" + FormType + "' FormType,*,'" + URName + "' URName FROM dbo.TT_Header({0},{1},{2})", CustomerId, Frm_CatID, CustEventId), cn);

            DataTable dt = new DataTable();
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cD;
            da.Fill(dt);
            return dt;
        }

    }
}