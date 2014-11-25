using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data.SqlClient;
using System.Data;

namespace TTF.App_Code
{
    public class Util
    {
        public Util()
        {

        }
        public SqlConnection sqlConn 
        {
            get
            {

                return new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Book10PE"].ConnectionString);
            }
        }

        public Control FindControlRecursive(Control rootControl, string controlID)
        {
            if (rootControl.ID == controlID) return rootControl;

            foreach (Control controlToSearch in rootControl.Controls)
            {
                Control controlToReturn =
                    FindControlRecursive(controlToSearch, controlID);
                if (controlToReturn != null) return controlToReturn;
            }
            return null;
        }

        public DataTable selectDBQuesry(string sql)
        {
            SqlConnection cn = sqlConn;
            DataTable dt = new DataTable();
            SqlCommand cD = new SqlCommand(sql, cn);
            cD.CommandType = CommandType.Text;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cD;
            da.Fill(dt);
            return dt;
        }

        public object selectDBScalar(string sql)
        {
            SqlConnection cn = sqlConn;
            DataTable dt = new DataTable();
            SqlCommand cD = new SqlCommand(sql, cn);
            cD.CommandType = CommandType.Text;
            cn.Open();
            object o = null;
            try
            {
                o = cD.ExecuteScalar();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                cn.Close();
            }
            return o;
        }
        public Exception executeSql(string sql)
        {
            Exception eex = null;
            SqlConnection cn = sqlConn;
            DataTable dt = new DataTable();
            SqlCommand cD = new SqlCommand(sql, cn);
            cD.CommandType = CommandType.Text;
            cn.Open();
            object o = null;
            try
            {
                o = cD.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                eex = ex;
                throw ex;
            }
            finally
            {
                cn.Close();
            }
            return eex;

        }
    }
}