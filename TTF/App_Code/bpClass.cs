using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

namespace TTF.App_Code
{
    public class bpClass
    {
        TTF.App_Code.Util u = new TTF.App_Code.Util();
        public bpClass()
        {        
        }
        public DataTable getbpClass(string s)
        {
            SqlConnection cn = u.sqlConn;
            SqlCommand cD = new SqlCommand(string.Format("SELECT * FROM dbo.TT_SelectList({0})", s), cn);
            cn.Open();
            SqlDataAdapter da = new SqlDataAdapter();
            DataTable dt = new DataTable();
            da.SelectCommand = cD;
            da.Fill(dt);
            da.Dispose();
            cD.Dispose();
            cn.Close();
            return dt;
        }
    }
}